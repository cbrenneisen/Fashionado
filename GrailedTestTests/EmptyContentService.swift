//
//  EmptyContentService.swift
//  GrailedTestTests
//
//  Created by Cbrenneisen on 1/20/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
@testable import GrailedTest

final class EmptyContentService<T: Item>: ServiceInterface {
    
    func fetch(using urlString: String, completion: @escaping Handler){
        DispatchQueue.global(qos: .userInitiated).async {
            // create and return an empty container
            let container = ItemContainer<T>(data: [], metadata: nil)
            completion(container, nil)
        }
    }
}
