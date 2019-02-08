//
//  ServiceInterface.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/20/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case data(String)
    case server
    case response(String)
}

protocol ServiceInterface {
    
    associatedtype T: Item
    
    func fetch(using urlString: String, completion: @escaping (ItemContainer<T>?, NetworkError?) -> ())
}

extension ServiceInterface {
    
    typealias Handler = (ItemContainer<T>?, NetworkError?) -> ()
}
