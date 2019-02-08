//
//  ContentViewController.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/15/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ContainerViewController: UIViewController {
    
    @IBOutlet weak var scrollView: ContentScrollView!
    @IBOutlet weak var segmentedControl: ContentSegmentedControl!
    
    private let disposeBag = DisposeBag()
    private let viewModel = ContainerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    /**
        Setup bindings for the View Controller
    */
    private func setupBindings(){
        // - bind the title
        viewModel
            .title
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        // bind content types
        viewModel
            .types
            .subscribe(onNext: { [unowned self] types in
                self.updateUI(with: types)
            }).disposed(by: disposeBag)
        
        // bind selected page via scroll view
        scrollView
            .selectedPage
            .throttle(0.5)
            .drive(onNext: { [unowned self] page in
                self.segmentedControl.select(page: page)
                self.viewModel.update(page: page)
            }).disposed(by: disposeBag)
        
        // bind selected page via segmented control
        segmentedControl
            .rx
            .selectedSegmentIndex
            .subscribe(onNext: { [unowned self] page in
                self.scrollView.select(page: page)
                self.viewModel.update(page: page)
            }).disposed(by: disposeBag)
    }
    
    /**
        Load content types into segmented control and scroll view
    */
    private func updateUI(with types: [ContentType]){
        scrollView.load(with: types, parent: self)
        segmentedControl.load(with: types)
    }
}
