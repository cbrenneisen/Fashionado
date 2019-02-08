//
//  ContentTableViewCell.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/16/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit
import Kingfisher

final class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "ContentTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // make sure old images are not showing when scrolling quickly
        thumbnailImageView.image = nil
    }
    
    /**
        Setup a cell's UI with a given display item
        - parameter item: The display item to show in the cell
    */
    func configure(with item: DisplayItem){
        
        switch item.type {
        case .real:
            guard let realItem = item as? RealDisplayItem else {
                fatalError("Invalid cofiguration")
            }
            setupRealContent(with: realItem)
        case .dummy:
            setupDummy()
        }
        
    }
    
    /**
        Display real content in the Table view Cell
    */
    private func setupRealContent(with item: RealDisplayItem){
        titleLabel.text = item.title
        dateLabel.text = item.date
        
        thumbnailImageView.kf.setImage(with: URL(string: item.image), placeholder: nil)
    }
    
    /**
        Show loading information in the Table View Cell
    */
    private func setupDummy(){
        //TODO: show animated loading activity
        
        titleLabel.text = "........"
        dateLabel.text =  "........"
        
        thumbnailImageView.image = UIImage.loading
    }
    
}
