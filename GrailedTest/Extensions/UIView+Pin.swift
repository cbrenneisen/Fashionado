//
//  UIView+Pin.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/20/19.
//  Copyright © 2019 CarlBrenneisen. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
        Add a view to a superview, taking up the full dimensions of the superview
    */
    func pin(to view: UIView){
        view.addSubview(self)
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}
