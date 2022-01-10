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
    static let kListTitle_p07 = "Project 07 - PokedexGo"
    static let kListTitle_p08 = "Project 08 - SimpleRSSReader"
    
    static let kListTitle_p09 = "Project 09 - PhotoScroll"
    static let kListTitle_p10 = "Project 10 - Interests"
    
    static let kListTitle_p19 = "Project 19 - Pinterest"
    static let kListTitle_p20 = "Project 20 - FlickrSearch"
//    static let kListTitle_p21 = "Project 21 - Browser"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}

extension MSYListViewController {
    
    
    private func setUpTableView() {
        let section1 = Section(headerTitle: "UITableView", items: [
            MSYListViewController.kListTitle_p03,
            MSYListViewController.kListTitle_p04,
            MSYListViewController.kListTitle_p05,
            MSYListViewController.kListTitle_p06,
            MSYListViewController.kListTitle_p07,
            MSYListViewController.kListTitle_p08,
        ])
        
        let section2 = Section(headerTitle: "UIScrollView", items: [
            MSYListViewController.kListTitle_p09,
            MSYListViewController.kListTitle_p10,
        ])
        
        let section3 = Section(headerTitle: "UICollectionView", items: [
            MSYListViewController.kListTitle_p19,
            MSYListViewController.kListTitle_p20,
        ])
        
        let dataSource = DataSource(sections: [section1, section2, section3])
        
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
            case MSYListViewController.kListTitle_p03:
                self?.presentNextPage(ctr: FBMeViewController(),
                                      title: selectItem)
                break
            case MSYListViewController.kListTitle_p04:
                self?.presentNextPage(ctr: TDItemListViewController(),
                                      title: selectItem)
                break
            case MSYListViewController.kListTitle_p05:
                self?.presentNextPage(ctr: ArtistListViewController(),
                                      title: selectItem)
                break
            case MSYListViewController.kListTitle_p06:
                self?.presentNextPage(ctr: CandyListViewController(),
                                      title: selectItem)
                break
            case MSYListViewController.kListTitle_p07:
                self?.presentNextPage(ctr: PokedexGoListViewController(),
                                      title: selectItem)
                break
            case MSYListViewController.kListTitle_p08:
                self?.presentNextPage(ctr: NewsListViewController(),
                                      title: selectItem)
            case MSYListViewController.kListTitle_p09:
                self?.presentNextPage(ctr: PhotoCollectionViewController(),
                                      title: selectItem)
            case MSYListViewController.kListTitle_p10:
                self?.presentNextPage(ctr: InterestsViewController(),
                                      title: selectItem)
            case MSYListViewController.kListTitle_p19:
                self?.presentNextPage(ctr: PhotoStreamViewController(),
                                      title: selectItem)
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
    
    private func presentNextPage(ctr: UIViewController, title: String?) {
        ctr.title = title
        let navCtr = MSYNavigationController(rootViewController: ctr)
        navCtr.modalPresentationStyle = .fullScreen
        self.present(navCtr, animated: true, completion: nil)
    }
}

