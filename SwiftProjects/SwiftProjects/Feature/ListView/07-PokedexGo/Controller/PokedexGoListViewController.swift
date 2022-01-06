//
//  PokedexGoListViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit
import RxSwift
import RxCocoa

class PokedexGoListViewController: MSYBaseViewController {
    var pokemons = LibraryAPI.sharedInstance.getPokemons()
    var filteredPokemons = [Pokemon]()
    fileprivate let disposeBag = DisposeBag()
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50.0))
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableHeaderView = searchBar
        tableView.rowHeight = 140.0
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(PokedexGoListCell.self, forCellReuseIdentifier: PokedexGoListCell.cellReuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "精灵列表"
//        definesPresentationContext = true
        createCloseItem()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filteredPokemons = pokemons
        configSearchBar()
    }
}

extension PokedexGoListViewController {
    private func configSearchBar()  {
        searchBar.rx.text
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [unowned self] query in
                    var isEmpty: Bool
                    if let empty = query?.isEmpty {
                        isEmpty = empty
                    } else {
                        isEmpty = true
                    }
                    
                    if isEmpty {
                        self.filteredPokemons = self.pokemons
                    } else {
                        self.filteredPokemons = self.pokemons.filter({ $0.name.contains(query!) })
                        //hasPrefix
                    }
                    
                    self.tableView.reloadData()
                }
            )
            .disposed(by: disposeBag)
    }
}

extension PokedexGoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokedexGoListCell.cellReuseId, for: indexPath) as! PokedexGoListCell
        cell.pokemonModel = filteredPokemons[indexPath.row]
        return cell
    }
}

extension PokedexGoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctr = PokedexGoDetailViewController()
        ctr.pokemon = filteredPokemons[indexPath.row]
        navigationController?.pushViewController(ctr, animated: true)
    }
}
