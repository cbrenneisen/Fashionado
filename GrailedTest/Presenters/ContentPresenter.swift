//
//  ContentPresenter.swift
//  GrailedTest
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PresenterInterface {
    
    associatedtype T: Item
    
    var displayContent: Driver<[DisplayItem]> { get }
    
    func fetch()
    func containsLoadingCells(_ indexPaths: [IndexPath]) -> Bool
}

// the number of loading cells to show after the loaded content
fileprivate let bufferCount = 5

final class ContentPresenter<T: Item>: PresenterInterface {

    /**
        All the content to display to the user
        Includes both real and buffer content
    */
    var displayContent: Driver<[DisplayItem]> {
        return Driver.combineLatest(
            interactor.content.asDriver(),
            buffer).map{ $0.0.toDisplay + $0.1.asGeneric }
    }
    
    /**
        A placeholder for future content, which still needs to be loaded from the server
        If we have already fetched all the content, this will be an empty array
     */
    private var buffer: Driver<[DummyDisplayItem]> {
        return interactor.finished.map{
            $0 ? [] : Array(repeating: DummyDisplayItem(), count: bufferCount)
        }.asDriver(onErrorJustReturn: [])
    }
    
    /**
        The amount of actual content (not including buffer cells)
    */
    private var itemCount: Int {
        return interactor.content.value.count
    }
    
    private let interactor: ContentInteractor<T, ContentService<T>>

    private let disposeBag = DisposeBag()
    
    init(interactor: ContentInteractor<T, ContentService<T>>) {
        self.interactor = interactor
    }
    
    /**
        Asks the interactor for more content
    */
    func fetch(){
        interactor.fetch()
    }
    
    func selected(indexPath: IndexPath){
        interactor.select(indexPath: indexPath)
    }
    
    /**
     Determines whether the given index paths correspond to cells that still need to be loaded
    */
    func containsLoadingCells(_ indexPaths: [IndexPath]) -> Bool {
        for ip in indexPaths{
            if ip.row >= itemCount {
                // row exists beyond the actual content
                return true
            }
        }
        return false
    }
}
