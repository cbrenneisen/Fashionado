//
//  ContentSegmentedControl.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit

final class ContentSegmentedControl: UISegmentedControl {
    
    func load(with contentTypes: [ContentType]){
        
        removeAllSegments()
        contentTypes.enumerated().forEach(){ i, val in
            insertSegment(with: nil, at: i, animated: false)
            setTitle(val.rawValue, forSegmentAt: i)
        }
        selectedSegmentIndex = 0
    }
    
    func select(page: Int){
        selectedSegmentIndex = page
    }
}
