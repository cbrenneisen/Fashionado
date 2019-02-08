//
//  DisplayItem.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/18/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

enum DisplayType {
    
    case real
    case dummy
}

protocol DisplayItem {
    
    var type: DisplayType { get }
    
}

