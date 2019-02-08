//
//  ContentTableView.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/16/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit

final class ContentTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup(){
        // configure cell
        let nib = UINib(nibName: ContentTableViewCell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
        
        // set up auto sizing cells
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100
    }
}
