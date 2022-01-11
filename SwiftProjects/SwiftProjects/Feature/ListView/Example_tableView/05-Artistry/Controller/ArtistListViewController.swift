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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configNavBar()
        createCloseItem()
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
    private func configNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let scrollBarApp = UINavigationBarAppearance()
            scrollBarApp.backgroundColor = .black
            scrollBarApp.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "Optima", size: 24.0) ?? UIFont.boldSystemFont(ofSize: 24.0)
            ]
            scrollBarApp.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.systemBlue
            ]
            
            let barApp = UINavigationBarAppearance()
            barApp.backgroundColor = .systemGreen
            barApp.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "Optima", size: 24.0) ?? UIFont.boldSystemFont(ofSize: 24.0)
            ]
            navigationController?.navigationBar.scrollEdgeAppearance = scrollBarApp
            navigationController?.navigationBar.standardAppearance = barApp
        } else {
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .systemGreen
//            navigationController?.navigationBar.backgroundColor = .black
//            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
            //设置大标题字体颜色
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.systemBlue
            ]
            //设置小标题(默认标题)字体颜色
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "Optima", size: 24.0) ?? UIFont.boldSystemFont(ofSize: 24.0)
            ]
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
