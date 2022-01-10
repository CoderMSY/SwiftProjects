//
//  InterestsCollectionViewCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/10.
//

import UIKit

class InterestsCollectionViewCell: MSYBaseCollectionViewCell {
    lazy var featuredImageView: UIImageView = {
        var featuredImageView = UIImageView()
        featuredImageView.contentMode = .scaleAspectFill
        
        return featuredImageView
    }()
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0) ?? UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.backgroundColor = .systemBackground
        return titleLabel
    }()
    
    var interest: Interest? {
        didSet {
            guard let interest = interest else { return }
            
            titleLabel.text = interest.title
            featuredImageView.image = interest.featuredImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        
        contentView.addSubview(featuredImageView)
        contentView.addSubview(titleLabel)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InterestsCollectionViewCell {
    private func initConstraints() {
        featuredImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView).multipliedBy(0.8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(featuredImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
