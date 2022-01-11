//
//  TDItemListDataProvider.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/31.
//

import UIKit

enum TDSection: Int {
    case toDo
    case done
}

class TDItemListDataProvider: NSObject {
    var itemManager: TDItemManager?
    
}

extension TDItemListDataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        
        guard let itemSection = TDSection(rawValue: section) else {
            fatalError()
        }
        
        let numberOfRows: Int
        
        switch itemSection {
        case .toDo:
            numberOfRows = itemManager.toDoCount
        case .done:
            numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TDConstants.ItemCellIdentifier, for: indexPath) as! TDItemCell
        
        guard let itemManager = itemManager else { fatalError() }
        guard let itemSection = TDSection(rawValue: indexPath.section) else { fatalError() }
        
        let item: TDItem
        
        switch itemSection {
        case .toDo:
            item = itemManager.item(at: indexPath.row)
        case .done:
            item = itemManager.doneItem(at: indexPath.row)
        }
        
        cell.configCell(with: item)
        
        return cell
    }
}

extension TDItemListDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemSection = TDSection(rawValue: indexPath.section) else { fatalError() }
        
        switch itemSection {
        case .toDo:
            NotificationCenter.default.post(
                name: Notification.ItemSelectedNotification,
                object: self,
                userInfo: ["index": indexPath.row]
            )
        case .done:
            break
        }
    }
    
    
}
