//
//  TumblrMenu.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/15.
//

import UIKit

class TumblrMenuItemView: UIView {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    init(frame: CGRect, imageName: String, title: String) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
