//
//  PluginTableView.swift
//  SwiftDemo
//
//  Created by Simon Miao on 2021/11/16.
//  Copyright © 2021 avatar. All rights reserved.
//

import UIKit

class PluginTableView<Configurator: ConfiguratorType>: UIView, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var dataSource: DataSource<Configurator.Item>
    private let configurator: Configurator
    
    var didSelectRow: ((UITableView, IndexPath) -> Void)?
    
    init(frame: CGRect, style: UITableView.Style, dataSource: DataSource<Configurator.Item>, configurator: Configurator) {
        self.dataSource = dataSource
        self.configurator = configurator
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), style: style)
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        configurator.registerCells(in: tableView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 数据源
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource.item(at: indexPath)
        return configurator.configuredCell(for: item, tableView: tableView, indexPath: indexPath)
    }

    // MARK: - 代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(tableView, indexPath)
    }
}

extension PluginTableView {
    
}
