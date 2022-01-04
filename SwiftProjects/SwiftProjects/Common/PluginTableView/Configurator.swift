//
//  Configurator.swift
//  SwiftDemo
//
//  Created by Simon Miao on 2021/11/16.
//  Copyright © 2021 avatar. All rights reserved.
//

import UIKit

protocol ConfiguratorType {
    associatedtype Item
    associatedtype Cell: UITableViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String
    func registerCells(in tableView: UITableView)
    func configure(cell: Cell, item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell
}

extension ConfiguratorType {
    func configuredCell(for item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell {
        let reuseId = self.reuseIdentifier(for: item, indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! Cell
        return self.configure(cell: cell, item: item, tableView: tableView, indexPath: indexPath)
    }
}

struct Configurator<Item, Cell: UITableViewCell>: ConfiguratorType {
    func configure(cell: Cell, item: Item, tableView: UITableView, indexPath: IndexPath) -> Cell {
        return configurator(cell, item, tableView, indexPath)
    }
    
    typealias CellConfigurator = (Cell, Item, UITableView, IndexPath) -> Cell
    
    let configurator: CellConfigurator
    let reuseIdentifier = "\(Cell.self)"
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String {
        return reuseIdentifier
    }
    
    func registerCells(in tableView: UITableView) {
        if let path = Bundle.main.path(forResource: reuseIdentifier, ofType: "nib"),
           FileManager.default.fileExists(atPath: path) {
            let nib = UINib(nibName: reuseIdentifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
        }
    }
}
