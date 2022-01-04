//
//  ArtistDetailViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

class ArtistDetailViewController: MSYBaseViewController {
    var selectedArtist: Artist?
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300.0
        
        tableView.register(WorkCell.self, forCellReuseIdentifier: WorkCell.cellReuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedArtist?.name
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension ArtistDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist?.works.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkCell.cellReuseId, for: indexPath) as? WorkCell
        cell?.work = selectedArtist?.works[indexPath.row]
        
        return cell ?? WorkCell()
    }
}

extension ArtistDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkCell else {
            return
        }
        
        guard var work = selectedArtist?.works[indexPath.row] else { return }
        
        work.isExpanded = !work.isExpanded
        selectedArtist?.works[indexPath.row] = work
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : cell.moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
