//
//  GrailedItem.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

protocol Item: Codable, Comparable {
    
    var id: Int { get }
    var title: String { get }
    var date: String { get }
    var image: String { get }
    
    var favorite: Bool { get set}
    
    static var endpoint: ContentAPI.Endpoint { get }
}

extension Item {
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        //compare dates and sort inversely
        return lhs.date > rhs.date
    }
}
