//
//  TDItemListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/31.
//

import UIKit

class TDItemListViewController: MSYBaseViewController {
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TDItemCell.self, forCellReuseIdentifier: TDConstants.ItemCellIdentifier)
        return tableView
    }()
    
    lazy var dataProvider: TDItemListDataProvider! = {
        var dataProvider = TDItemListDataProvider()
        
        return dataProvider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCloseItem()
        initBarItem()
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        dataProvider.itemManager = TDItemManager()
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(_:)), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func showDetails(_ sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int else { fatalError() }
        
        let detailCtr = TDDetailViewController()
        detailCtr.item = dataProvider.itemManager?.item(at: index)
        
        navigationController?.pushViewController(detailCtr, animated: true)
    }
}

extension TDItemListViewController {
    private func initBarItem() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:)))
        
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func addItem(_ sender: UIBarButtonItem) {
        let ctr = TDAddItemViewController()
        ctr.itemManager = dataProvider.itemManager
        let navCtr = MSYNavigationController(rootViewController: ctr)
        navCtr.modalPresentationStyle = .fullScreen
        self.present(navCtr, animated: true, completion: nil)
    }
}
