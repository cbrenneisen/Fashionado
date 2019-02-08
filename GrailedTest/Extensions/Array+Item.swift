//
//  Array.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/19/19.
//  Copyright © 2019 CarlBrenneisen. All rights reserved.
//

import Foundation

extension Array where Element: Item {
    
    /**
        Convert an array of Items to Display Items (to show to user)
    */
    var toDisplay: [DisplayItem] {
        return self.compactMap{
            RealDisplayItem(item: $0)
        }
    }
}

extension Array where Element: DisplayItem {

    /**
        Convert an array of specific Display Items to generic Display Items
     */
    var asGeneric: [DisplayItem] {
        return self as [DisplayItem]
    }
    
}
