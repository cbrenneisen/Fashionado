//
//  ItemViewController.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/16/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContentController<T: Item>: UIViewController, UITableViewDataSourcePrefetching {

    private lazy var tableView = ContentTableView(frame: self.view.bounds)
    
    lazy var presenter: ContentPresenter<T> = {
        //TODO: Proper Dependency Injection

        let service = ContentService<T>()
        let interactor = ContentInteractor(service: service)
        return ContentPresenter(interactor: interactor)
    }()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    //MARK: - Custom
    
    private func setupUI(){
        tableView.pin(to: view)
        tableView.prefetchDataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBindings(){
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] ip in
                self?.presenter.selected(indexPath: ip)
            }).disposed(by: disposeBag)
        
        presenter
            .displayContent
            .drive(tableView.rx.items(
                cellIdentifier: ContentTableViewCell.identifier,
                cellType: ContentTableViewCell.self)){ _, item, cell in
                    cell.configure(with: item)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Prefetch Data Source
    
    // Note: normally these would be written in an extension,
    // But this is not possible to the generic constraint on the View Controller
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    
        if presenter.containsLoadingCells(indexPaths) {
            presenter.fetch()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //TODO: cancel network request for additional information if necessary
        
    }
}
