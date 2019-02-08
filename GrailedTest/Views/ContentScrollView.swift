//
//  ContentScrollView.swift
//  GrailedTest
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ContentScrollView: UIScrollView {
    
    var selectedPage: Driver<Int> {
        return scrollDelegate.selectedPage.asDriver(onErrorJustReturn: 0)
    }
    
    private let scrollDelegate = ContentScrollDelegate()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /**
        Setup scroll view as needed
    */
    private func setup(){
        //alwaysBounceVertical = false
        self.contentInsetAdjustmentBehavior = .never
        delegate = scrollDelegate
    }
    
    /**
        Scroll to a given page
        - parameter page: The page to scroll to
    */
    func select(page: Int){
        let newX = CGFloat(page) * frame.size.width
        setContentOffset(CGPoint(x: newX, y: 0), animated: true)
    }
    
    /**
     Load View Controllers for the given Content Types inside the Scroll View
     - parameter contentTypes: The types of content to show in the Scroll View
     - parameter parent: The View Controller that owns the Scroll View
    */
    func load(with contentTypes: [ContentType], parent: UIViewController){
        
        frame = parent.view.bounds
        
        // prepare content size
        updateSize(pages: contentTypes.count)
        
        // add all content view controllers
        contentTypes.enumerated().forEach(){ i, val in
            add(viewController: val.item(), parent: parent, offset: i)
        }
    }
}

fileprivate class ContentScrollDelegate: NSObject, UIScrollViewDelegate {
    
    let selectedPage = PublishSubject<Int>()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
        
        //determine if page was changed
        let pageWidth = scrollView.frame.size.width
        let page = Int(round(scrollView.contentOffset.x / pageWidth))
        
        selectedPage.onNext(page)
    }
}

