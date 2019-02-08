//
//  ContainerViewModel.swift
//  GrailedTest
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ContainerViewModel {
    
    var title: Driver<String> {
        return Driver.combineLatest(
            currentPage.asDriver(),
            types.asDriver()).map{ $1[$0].rawValue }
    }
    
    let currentPage = BehaviorRelay<Int>(value: 0)

    let types = BehaviorRelay<[ContentType]>(value: [.article, .search])

    func update(page: Int){
        currentPage.accept(page)
    }
    
}
