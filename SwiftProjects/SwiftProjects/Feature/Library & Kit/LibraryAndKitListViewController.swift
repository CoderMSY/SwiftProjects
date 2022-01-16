//
//  LibraryAndKitListViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class LibraryAndKitListViewController: MSYBaseViewController {
    private let kListTitle_p21 = "Project 21 - Browser"
    private let kListTitle_p22 = "Project 12 - Tumblr"
    private let kListTitle_p23 = "Project 13 - TwitterBird"
    private let kListTitle_p24 = "Project 14 - QuoraDots"
    private let kListTitle_p25 = "Project 15 - SnapchatMenu"
    private let kListTitle_p26 = "Project 16 - SpotifySignIn"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension LibraryAndKitListViewController {
    private func setUpTableView() {
        let section1 = Section(headerTitle: "Animations", items: [
            kListTitle_p21,
            kListTitle_p22,
            kListTitle_p23,
            kListTitle_p24,
            kListTitle_p25,
            kListTitle_p26,
        ])
        
        let dataSource = DataSource(sections: [section1])
        
        let configuartor = Configurator{ (cell, model: String, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model
            return cell
        }
        
        let pluginTableView = PluginTableView(frame: view.bounds, style: .grouped, dataSource: dataSource, configurator: configuartor)
        pluginTableView.tableView.tableFooterView = UIView()
        view.addSubview(pluginTableView)
        
        pluginTableView.didSelectRow = { [weak self] (tableView, indexPath) in
//            let section = pluginTableView.dataSource[indexPath.row]
            let selectItem = pluginTableView.dataSource.item(at: indexPath)
            switch selectItem {
            case self?.kListTitle_p21:
                self?.presentNextPage(ctr: BrowserViewController(),
                                      title: nil)
            case self?.kListTitle_p22:
                self?.presentNextPage(ctr: TumblrMainViewController(),
                                      title: selectItem)
            case self?.kListTitle_p23:
                self?.presentNextPage(ctr: TwitterBirdViewController(),
                                      title: nil)
            case self?.kListTitle_p24:
                self?.presentNextPage(ctr: QuoraDotsViewController(),
                                      title: selectItem)
            case self?.kListTitle_p25:
                self?.presentNextPage(ctr: SnapMainViewController(),
                                      title: selectItem)
            case self?.kListTitle_p26:
                self?.presentNextPage(ctr: SpotifyMasterViewController(),
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

