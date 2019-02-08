//
//  ContentInteractor.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/18/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol InteractorInterface {
    
    associatedtype T: Item
    
    func fetch()
    func select(indexPath: IndexPath)
}

final class ContentInteractor<T, U: ServiceInterface> where U.T == T {
    
    let content = BehaviorRelay<[T]>(value: [])
    let finished = BehaviorRelay<Bool>(value: false)
    
    private let service: U
    private let disposeBag = DisposeBag()
    private var fetching = false
    
    private var currentURL: String
    
    init(service: U) {
        self.service = service
        
        // fetch the first page of content
        self.currentURL = T.endpoint.fullURL
        fetch()
    }

    /**
     Toggle favorite
     - parameter indexPath: The location of the item to toggle
    */
    func select(indexPath: IndexPath) {
        var value = content.value
        value[indexPath.row].favorite.toggle()
        content.accept(value)
    }
    
    /**
        Ask the Content Service for more data
    */
    func fetch(){
        // do not allow fetches if we have already seen all the content
        // only allow one fetch request at a time
        guard !finished.value, !fetching else { return }
        
        fetching = true
        
        service.fetch(using: currentURL){ [weak self] container, error in
            self?.handleResponse(data: container, error: error)
        }
    }
    
    /**
        Handle the response from the Content Service
        - parameter data: Properly formatted response from the server
        - parameter error: Any error that occurred - if the request was successful, this will be nil
    */
    private func handleResponse(data: ItemContainer<T>?, error: NetworkError?){
        fetching = false // allow future requests now
    
        //TODO: handle potential errors
        
        guard let container = data else {
            finished.accept(true) // if no data was returned, there is nothing more to do
            return
        }
        
        setupPagination(using: container.nextURL)
        content.append(container.data.sorted())
    }
    
    /**
        Configure pagination by verifying the url for the next page
        - parameter endpoint: The endpoint for the next page (not a full URL)
    */
    private func setupPagination(using endpoint: String?){
        
        if let string = endpoint {
            // set next page of data
            currentURL = ContentAPI.makeURL(with: string)
        }else {
            // if there is no next url, we have seen all the data
            finished.accept(true)
        }
    }
}
