//
//  MSYAnimationsListViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/14.
//

import UIKit

class MSYAnimationsListViewController: MSYBaseViewController {
    private let kListTitle_p11 = "Project 11 - Animations"
    private let kListTitle_p12 = "Project 12 - Tumblr"
    private let kListTitle_p13 = "Project 13 - TwitterBird"
    private let kListTitle_p14 = "Project 14 - QuoraDots"
    private let kListTitle_p15 = "Project 15 - SnapchatMenu"
    private let kListTitle_p16 = "Project 16 - SpotifySignIn"
    private let kListTitle_3DEffects = "Project - 3DEffects"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension MSYAnimationsListViewController {
    private func setUpTableView() {
        let section1 = Section(headerTitle: "Animations", items: [
            kListTitle_p11,
            kListTitle_p12,
            kListTitle_p13,
            kListTitle_p14,
            kListTitle_p15,
            kListTitle_p16,
            kListTitle_3DEffects,
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
            case self?.kListTitle_p11:
                self?.presentNextPage(ctr: AnimationsExampleViewController(),
                                      title: selectItem)
            case self?.kListTitle_p12:
                self?.presentNextPage(ctr: TumblrMainViewController(),
                                      title: selectItem)
            case self?.kListTitle_p13:
                self?.presentNextPage(ctr: TwitterBirdViewController(),
                                      title: nil)
            case self?.kListTitle_p14:
                self?.presentNextPage(ctr: QuoraDotsViewController(),
                                      title: selectItem)
            case self?.kListTitle_p15:
                self?.presentNextPage(ctr: SnapMainViewController(),
                                      title: selectItem)
            case self?.kListTitle_p16:
                self?.presentNextPage(ctr: SpotifyMasterViewController(),
                                      title: selectItem)
            case self?.kListTitle_3DEffects:
                self?.presentNextPage(ctr: MSY3DEffectsViewController(),
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

