//
//  RoundedCornersView.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/10.
//

import UIKit

class RoundedCornersView: UIView {
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var captionLabel: UILabel = {
        var captionLabel = UILabel()
        captionLabel.textColor = .white
        captionLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12.0) ?? UIFont.boldSystemFont(ofSize: 12.0)
        return captionLabel
    }()
    lazy var commentLabel: UILabel = {
        var commentLabel = UILabel()
        commentLabel.textColor = .white
//        commentLabel.font = UIFont(name: "AvenirNext-Regular", size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)
        commentLabel.font = UIFont.systemFont(ofSize: 10.0)
        commentLabel.numberOfLines = 0
        return commentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cornerRadius = 5.0
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        
        backgroundColor = UIColor(r: 12, g: 92, b: 42, a: 1.0)
        addSubview(imageView)
        addSubview(captionLabel)
        addSubview(commentLabel)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RoundedCornersView {
    private func initConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(4.0)
            make.trailing.equalToSuperview().offset(-4.0)
            make.height.equalTo(17.0)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom)
            make.leading.trailing.equalTo(captionLabel)
//            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
