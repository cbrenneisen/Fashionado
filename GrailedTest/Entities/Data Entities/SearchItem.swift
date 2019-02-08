//
//  SearchItem.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/15/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

struct SearchItem: Item {
    
    let id: Int
    let title: String
    let date: String
    let image: String
    
    var favorite: Bool = false
    
    static let endpoint = ContentAPI.Endpoint.search
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case date = "published_at"
        case image = "image_url"
    }
}
