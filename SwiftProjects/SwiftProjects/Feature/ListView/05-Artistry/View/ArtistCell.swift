//
//  ArtistCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

class ArtistCell: MSYBaseTableViewCell {
    lazy var bioLab: UILabel = {
        let bioLab = UILabel()
        bioLab.textColor = .systemGray
        bioLab.numberOfLines = 0
        return bioLab
    }()
    lazy var nameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.textColor = .white
        nameLab.backgroundColor = .systemYellow
        nameLab.textAlignment = .center
        return nameLab
    }()
    lazy var artistImageView: UIImageView = {
        let artistImageView = UIImageView()
        artistImageView.contentMode = .scaleAspectFit
        return artistImageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //UITableView分离线会被系统默认的选择效果给覆盖
        selectionStyle = .none
        contentView.addSubview(artistImageView)
        contentView.addSubview(nameLab)
        contentView.addSubview(bioLab)
        
        initConstraints()
    }
    
    func setModel(_ model : Artist) {
        artistImageView.image = model.image
        nameLab.text = model.name
        bioLab.text = model.bio
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArtistCell {
    private func initConstraints() {
        let marginTop = 10
        let margin = 15
        
        artistImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(marginTop)
            make.leading.equalTo(contentView).offset(margin)
            make.trailing.equalTo(contentView.snp.centerX).offset(margin)
        }
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(artistImageView.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(margin)
            make.bottom.lessThanOrEqualTo(contentView).offset(-marginTop)
            make.trailing.equalTo(contentView.snp.centerX)
            make.height.equalTo(25)
        }
        bioLab.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(marginTop)
            make.leading.equalTo(artistImageView.snp.trailing).offset(margin)
            make.bottom.equalTo(contentView).offset(-marginTop)
            make.trailing.equalTo(contentView).offset(-margin)
        }
    }
}
