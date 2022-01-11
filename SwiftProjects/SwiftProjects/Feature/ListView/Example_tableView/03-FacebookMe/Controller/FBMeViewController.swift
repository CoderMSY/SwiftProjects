//
//  FBMeViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit
import SwiftUI

class FBMeViewController: MSYBaseViewController {
    typealias RowModel = [String: String]
    
    fileprivate var user: FBMeUser {
        get {
            return FBMeUser(name: "BayMax", education: "University")
        }
    }
    fileprivate var dataSource: [[String: Any]] {
        get {
            return FBTableKeys.populate(withUser: user)
        }
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: view.frame, style: .grouped)
        view.register(FBMeBaseCell.self, forCellReuseIdentifier: FBMeBaseCell.cellReuseId)
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        
        return view
    }()
    override func viewDidLoad() {
        createCloseItem()
        view.backgroundColor = FBSpecs.color.gray
        title = "Facebook"
        navigationController?.navigationBar.barTintColor = FBSpecs.color.tint
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.reloadData()
    }
    
    fileprivate func rows(at section: Int) -> [Any] {
        return dataSource[section][FBTableKeys.Rows] as! [Any]
    }
    fileprivate func title(at section: Int) -> String? {
        return dataSource[section][FBTableKeys.Section] as? String
    }
    
    fileprivate func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }
}

extension FBMeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let rows = rows(at: section) else { return 0 }
        let rows = rows(at: section)
        return rows.count
//        return rows(at: section).count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = title(at: section) ?? ""
        title = "header: " + title
        return title
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = rowModel(at: indexPath)
        
        guard let title = model[FBTableKeys.Title] else {
            return UITableViewCell()
        }
        
        var cell: UITableViewCell
        if title == user.name {
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.detailTextLabel?.text = model[FBTableKeys.SubTitle]
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FBMeBaseCell.cellReuseId, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if let imageName = model[FBTableKeys.ImageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != FBTableKeys.logout {
            cell.imageView?.image = UIImage(named: FBSpecs.imageName.placeholder)
        }
        
        return cell
    }
}

extension FBMeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = rowModel(at: indexPath)
        
        guard let title = model[FBTableKeys.Title] else { return 0.0 }
        
        if title == user.name {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = rowModel(at: indexPath)
        
        guard let title = model[FBTableKeys.Title] else { return }
        
        if title == FBTableKeys.seeMore || title == FBTableKeys.addFavorites {
            cell.textLabel?.textColor = FBSpecs.color.tint
            cell.accessoryType = .none
        } else if title == FBTableKeys.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = FBSpecs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
}
