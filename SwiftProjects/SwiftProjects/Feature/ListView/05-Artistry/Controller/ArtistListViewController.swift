//
//  ArtistListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

class ArtistListViewController: MSYBaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140.0
        
        tableView.register(ArtistCell.self, forCellReuseIdentifier: ArtistCell.cellReuseId)
        
        return tableView
    }()
    
    lazy var artistList: [Artist] = {
        artistList = Artist.artistsFromBundle()
        return artistList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .systemGreen
        view.addSubview(tableView)
        initConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension ArtistListViewController {
    private func initConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension ArtistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.cellReuseId) as! ArtistCell
        
        let artist = artistList[indexPath.row]
        cell.setModel(artist)
        
        return cell
    }
}

extension ArtistListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctr = ArtistDetailViewController()
        ctr.selectedArtist = artistList[indexPath.row]
        navigationController?.pushViewController(ctr, animated: true)
    }
}
