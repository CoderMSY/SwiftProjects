//
//  MSYKitFoundationViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import UIKit

class MSYKitFoundationViewController: MSYBaseViewController {
    private let kListTitle_p1 = "Project 01 - GoodAsOldPhones"
    private let kListTitle_p2 = "Project 02 - Stopwatch"
    private let kListTitle_closure = "Closure"
//    private let kListTitle_p4 = "Project 14 - QuoraDots"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension MSYKitFoundationViewController {
    private func setUpTableView() {
        let section = Section(items: [
            kListTitle_p1,
            kListTitle_p2,
            kListTitle_closure
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
            let selectItem = pluginTableView.dataSource.item(at: indexPath)
            switch selectItem {
                
            case self?.kListTitle_p1:
                let tabBarCtr = GoodAsOldPhonesTabBarCtrConfig().tabBarCtr
                self?.present(tabBarCtr, animated: true, completion: nil)
//                self?.presentNextPage(ctr: tabBarCtr,
//                                      title: selectItem);
                break
            case self?.kListTitle_p2:
                self?.present(StopwatchViewController(), animated: true, completion: nil)
//                self?.presentNextPage(ctr: StopwatchViewController(),
//                                      title: selectItem);
                break
            case self?.kListTitle_closure:
                self?.presentNextPage(ctr: MSYClosureViewController(),
                                      title: selectItem)
            default:
                break
            }
        }
    }
    
    private func presentNextPage(ctr: UIViewController, title: String?) {
        ctr.title = title
        let navCtr = MSYNavigationController(rootViewController: ctr)
        navCtr.modalPresentationStyle = .fullScreen
        self.present(navCtr, animated: true, completion: nil)
    }
}
