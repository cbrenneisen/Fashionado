//
//  ContentType.swift
//  GrailedTest
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import UIKit

enum ContentType: String {
    
    case article = "Articles"
    case search = "Search Items"
    
    func item() -> UIViewController {
        switch self {
        case .article:
            return ContentController<Article>()
        case .search:
            return ContentController<SearchItem>()
        }
    }
}
