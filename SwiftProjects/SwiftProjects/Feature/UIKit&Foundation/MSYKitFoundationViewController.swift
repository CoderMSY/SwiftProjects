//
//  MSYKitFoundationViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import UIKit

class MSYKitFoundationViewController: MSYBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension MSYKitFoundationViewController {
    private func setUpTableView() {
        let section = Section(items: [
            "Project 01 - GoodAsOldPhones",
            "Project 02 - Stopwatch",
        ])
        let dataSource = DataSource(sections: [section])
        
        let configuartor = Configurator{ (cell, model: String, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model
            return cell
        }
        
        let pluginTableView = PluginTableView(frame: view.bounds, style: .plain, dataSource: dataSource, configurator: configuartor)
        pluginTableView.tableView.tableFooterView = UIView()
        view.addSubview(pluginTableView)
        
        pluginTableView.didSelectRow = { [weak self] (tableView, indexPath) in
            
            switch indexPath.row {
                
            case 0:
                let tabBarCtr = GoodAsOldPhonesTabBarCtrConfig().tabBarCtr
                self?.present(tabBarCtr, animated: true, completion: nil)
//                self?.navigationController?.pushViewController(tabBarCtr, animated: true)
                break
            case 1:
                self?.present(StopwatchViewController(), animated: true, completion: nil)
//                self?.navigationController?.pushViewController(StopwatchViewController(), animated: true)
                break
            default:
                break
            }
        }
    }
}
