//
//  ProductListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import UIKit

class ProductListViewController: MSYBaseViewController {
    private var products: [Product]?
    
    private lazy var tableView: UITableView! = {
        var tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        //创建表头标签
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30))
        headerLabel.text = "product list"
        tableView.tableHeaderView = headerLabel
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "产品列表"
        
        view.addSubview(tableView)
        loadDataSource()
    }
}

extension ProductListViewController {
    private func loadDataSource() {
        products = [
            Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
        
        tableView.reloadData()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: String(describing: UITableViewCell.self))
        }
        let model = products?[indexPath.row]
        cell?.textLabel?.text = model?.name
        
        if let imageName = model?.cellImageName {
            cell?.imageView?.image = UIImage(named: imageName)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = products?[indexPath.row]
        
        let productCtr: ProductViewController = ProductViewController()
        productCtr.product = model

        self.navigationController?.pushViewController(productCtr, animated: true)
    }
}
