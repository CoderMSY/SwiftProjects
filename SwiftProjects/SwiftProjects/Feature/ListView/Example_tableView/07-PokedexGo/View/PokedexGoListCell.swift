//
//  PokedexGoListCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import Foundation
import UIKit

class PokedexGoListCell: MSYBaseTableViewCell {
    lazy var idLabel: UILabel = {
        var idLabel = UILabel()
        idLabel.textAlignment = .center
        return idLabel
    }()
    lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    lazy var pokeImageView: UIImageView = {
        var pokeImageView = UIImageView()
        pokeImageView.image = UIImage(named: "pokedexGo_default")
        return pokeImageView
    }()
    
    var pokemonModel: Pokemon? {
        didSet {
            guard let model = pokemonModel else {
                return
            }
            
            idLabel.text = String(format: "#%03d", model.id)
            nameLabel.text = model.name
            
            NotificationCenter.default.post(name: Notification.Name(kNotification_downloadImage), object: nil, userInfo: [
                "pokeImageView": pokeImageView,
                "pokeImageUrl": model.pokeImgUrl
            ])
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(pokeImageView)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokedexGoListCell {
    private func initConstraints() {
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(96)
            make.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(idLabel.snp.bottom)
            make.leading.equalTo(idLabel)
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(idLabel)
        }
        pokeImageView.snp.makeConstraints { make in
            make.leading.equalTo(idLabel.snp.trailing).offset(28)
            make.centerY.equalToSuperview()
            make.size.equalTo(128)
        }
    }
}
