//
//  ScrollView.swift
//  GrailedTest
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    /**
     Expand or shrink the Scroll View to fit a given number of pages
     - parameter pages: The number of pages to make room for
    */
    func updateSize(pages: Int){
        let width = CGFloat(pages) * self.bounds.width
        contentSize = CGSize(width: width, height: frame.height)
    }
    
    /**
     Add a view controller to the scroll view in a certain page
     - parameter viewController: The View Controller to add to the Scroll View
     - parameter parent: The View Controller that owns the Scroll View
     - parameter offset: The page where the new View Controller will be inserted
    */
    func add(viewController: UIViewController, parent: UIViewController, offset: Int){
        
        // set the proper positioning of the new View Controller
        viewController.view.frame = CGRect(
            x: CGFloat(offset) * bounds.width,
            y: 0,
            width: bounds.width,
            height: bounds.height)
        
        // display
        parent.addChild(viewController)
        addSubview(viewController.view)
    }

}
