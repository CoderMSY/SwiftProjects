//
//  MSYListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit

class MSYListViewController: MSYBaseViewController {
    static let kListTitle_p03 = "Project 03 - FacebookMe"
    static let kListTitle_p04 = "Project 04 - TodoTDD"
    static let kListTitle_p05 = "Project 05 - Artistry"
    static let kListTitle_p06 = "Project 06 - CandySearch"
    
    static let kListTitle_p09 = "Project 09 - PhotoScroll"
    static let kListTitle_p10 = "Project 10 - Interests"
    
    static let kListTitle_p20 = "Project 20 - FlickrSearch"
    static let kListTitle_p21 = "Project 21 - Browser"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension MSYListViewController {
    
    
    private func setUpTableView() {
        let section1 = Section(items: [
            MSYListViewController.kListTitle_p03,
            MSYListViewController.kListTitle_p04,
            MSYListViewController.kListTitle_p05,
            MSYListViewController.kListTitle_p06,
        ])
        
        let section2 = Section(items: [
            MSYListViewController.kListTitle_p09,
            MSYListViewController.kListTitle_p10,
        ])
        
        let section3 = Section(items: [
            MSYListViewController.kListTitle_p20,
            MSYListViewController.kListTitle_p21,
        ])
        
        let dataSource = DataSource(sections: [section1, section2, section3])
        
        let configuartor = Configurator{ (cell, model: String, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model
            return cell
        }
        
        let pluginTableView = PluginTableView(frame: view.bounds, style: .plain, dataSource: dataSource, configurator: configuartor)
        pluginTableView.tableView.tableFooterView = UIView()
        view.addSubview(pluginTableView)
        
        pluginTableView.didSelectRow = { [weak self] (tableView, indexPath) in
//            let section = pluginTableView.dataSource[indexPath.row]
            let selectItem = pluginTableView.dataSource.item(at: indexPath)
            switch selectItem {
            case MSYListViewController.kListTitle_p03:
                let navCtr = MSYNavigationController(rootViewController: FBMeViewController())
                self?.present(navCtr, animated: true, completion: nil)
//                self?.navigationController?.pushViewController(FBMeViewController(), animated: true)
                break
            case MSYListViewController.kListTitle_p04:
                let ctr = TDItemListViewController()
                ctr.title = selectItem
                let navCtr = MSYNavigationController(rootViewController: ctr)
                navCtr.modalPresentationStyle = .fullScreen
                self?.present(navCtr, animated: true, completion: nil)
                break
            case MSYListViewController.kListTitle_p05:
                let ctr = ArtistListViewController()
                ctr.title = selectItem
                let navCtr = MSYNavigationController(rootViewController: ctr)
                navCtr.modalPresentationStyle = .fullScreen
                self?.present(navCtr, animated: true, completion: nil)
                break
            case MSYListViewController.kListTitle_p06:
                let ctr = CandyListViewController()
                ctr.title = selectItem
                let navCtr = MSYNavigationController(rootViewController: ctr)
                navCtr.modalPresentationStyle = .fullScreen
                self?.present(navCtr, animated: true, completion: nil)
                break
            default:
                break
            }
            
            switch indexPath.row {
                
            case 0:
            
                break
            case 1:
                break
            default:
                break
            }
        }
    }
}

