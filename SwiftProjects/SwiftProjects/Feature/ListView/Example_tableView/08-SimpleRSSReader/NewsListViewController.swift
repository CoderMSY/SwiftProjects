//
//  NewsListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit

class NewsListViewController: MSYBaseViewController {
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .singleLine
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.cellReuseId)
        return tableView
    }()
    
    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    fileprivate var rssItems: [(title: String, description: String, pubDate: String)]?
    fileprivate var cellStates: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCloseItem()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadDataSource()
    }
}

extension NewsListViewController {
    private func loadDataSource() {
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
        
        return rssItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.cellReuseId) as! NewsListCell
        
        if let item = rssItems?[indexPath.row] {
            cell.item = item
//            (cell.titleLabel.text, cell.dateLabel.text, cell.descriptionLabel.text) = (item.title, item.pubDate, item.description)
            
            if let cellState = cellStates?[indexPath.row] {
                cell.descriptionLabel.numberOfLines = cellState == .expanded ? 0 : 4
            }
        }
        
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsListCell
        
        tableView.beginUpdates()
        if var status = cellStates?[indexPath.row] {
            status = status == .collapsed ? .expanded : .collapsed
            cellStates?[indexPath.row] = status
            
            cell.descriptionLabel.numberOfLines = status == .expanded ? 0 : 4
        }
        
        tableView.endUpdates()
    }
}
