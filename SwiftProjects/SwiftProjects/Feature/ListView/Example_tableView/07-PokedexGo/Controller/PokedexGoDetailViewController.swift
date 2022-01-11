//
//  PokedexGoDetailViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit

class PokedexGoDetailViewController: MSYBaseViewController {
    
    lazy var nameIdLabel: UILabel = {
        var nameIdLabel = UILabel()
        nameIdLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        return nameIdLabel
    }()
    lazy var pokeImageView: UIImageView = {
        var pokeImageView = UIImageView()
        pokeImageView.image = UIImage(named: "pokedexGo_default")
        
        return pokeImageView
    }()
    lazy var pokeInfoLabel: UILabel = {
        var pokeInfoLabel = UILabel()
        pokeInfoLabel.numberOfLines = 0;
        return pokeInfoLabel
    }()
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            
            title = pokemon.name
            let idStr = pokemon.id < 10 ? " #00\(pokemon.id)" : pokemon.id < 100 ? " #0\(pokemon.id)" : " #\(pokemon.id)"
            nameIdLabel.text = pokemon.name + idStr
//            pokeImageView.image = LibraryAPI.sharedInstance.downloadImg(pokemon.pokeImgUrl)
            pokeInfoLabel.text = pokemon.detailInfo
            
            NotificationCenter.default.post(name: Notification.Name(kNotification_downloadImage), object: nil, userInfo: [
                "pokeImageView": pokeImageView,
                "pokeImageUrl": pokemon.pokeImgUrl
            ])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameIdLabel)
        view.addSubview(pokeImageView)
        view.addSubview(pokeInfoLabel)
        initConstraints()
    }
}

extension PokedexGoDetailViewController {
    private func initConstraints() {
        let marginTop = UIView.msy_statusHeight + UIView.msy_navBarHeight
//        let marginTop = navigationController?.navigationBar.bounds.size.height ?? 0
        nameIdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(marginTop + 25)
            make.leading.greaterThanOrEqualToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
        
        pokeImageView.snp.makeConstraints { make in
            make.top.equalTo(nameIdLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(26)
//            make.size.equalTo(100)
            make.width.equalTo(pokeInfoLabel.snp.width).multipliedBy(0.6)
            make.width.equalTo(pokeImageView.snp.height)
        }
        pokeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(pokeImageView)
            make.leading.equalTo(pokeImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-26)
            make.bottom.lessThanOrEqualToSuperview().offset(-30)
        }
    }
}
