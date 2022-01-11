//
//  TDItemManager.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/31.
//

import UIKit

class TDItemManager {
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    
    private var toDoItems = [TDItem]()
    private var doneItems = [TDItem]()
    
    var toDoPathUrl: URL {
        let fileUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let docUrl = fileUrls.first else {
            fatalError("Something went wrong. Documents url could not be found")
        }
        
        return docUrl.appendingPathComponent("toDoItems.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        if let nsToDoItems = NSArray(contentsOf: toDoPathUrl) {
            for dict in nsToDoItems {
                if let toDoTtem = TDItem(dict: dict as! [String : Any]) {
                    toDoItems.append(toDoTtem)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    @objc func save() {
        let nsToDoItems = toDoItems.map { $0.plistDict }
        
        guard nsToDoItems.count > 0 else {
            try? FileManager.default.removeItem(at: toDoPathUrl)
            
            return
        }
        
        do {
            let plistData = try PropertyListSerialization.data(
                fromPropertyList: nsToDoItems,
                format: PropertyListSerialization.PropertyListFormat.xml,
                options: PropertyListSerialization.WriteOptions(0)
            )
            try plistData.write(to: toDoPathUrl,
                                options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    
    func add(_ item: TDItem) {
        toDoItems.append(item)
    }
    
    func item(at index: Int) -> TDItem {
        return toDoItems[index]
    }
    
    func doneItem(at index: Int) -> TDItem {
        return doneItems[index]
    }
    
    func checkItem(at index: Int) {
        let checkedItem = toDoItems.remove(at: index)
        doneItems.append(checkedItem)
    }
    
    func uncheckItem(at index: Int) {
      let uncheckedItem = doneItems.remove(at: index)
      toDoItems.append(uncheckedItem)
    }
    
    func removeAll() {
      toDoItems.removeAll()
      doneItems.removeAll()
    }
}
