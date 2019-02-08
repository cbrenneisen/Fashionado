//
//  ItemContainer.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

/**
    A container for content from the server
*/
struct ItemContainer<T: Item>: Codable {
    
    let data: [T]             // The contents of the response
    let metadata: Metadata?    // Additional information, if it exists
    
    /**
        If the response is paginated, this will be the url of the next page
    */
    var nextURL: String? {
        return metadata?.pagination.next
    }
    
    init(data: [T]) {
        self.data = data
        self.metadata = nil
    }
}

struct Metadata: Codable {
    
    let pagination: Pagination
}

/**
    Any pagination information returned from the server
*/
struct Pagination: Codable {
    
    let next: String             // next page
    let current: String?         // current page
    let previous: String?        // previous page
    
    enum CodingKeys: String, CodingKey {
        case next = "next_page"
        case current = "current_page"
        case previous = "previous_page"
    }
}
