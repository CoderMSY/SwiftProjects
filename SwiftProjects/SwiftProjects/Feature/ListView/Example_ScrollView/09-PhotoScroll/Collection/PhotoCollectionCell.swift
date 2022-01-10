//
//  PhotoCollectionCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/7.
//

import UIKit

class PhotoCollectionCell: MSYBaseCollectionViewCell {
    lazy var photoIV: UIImageView = {
        var photoIV = UIImageView()
        photoIV.contentMode = .scaleToFill
        return photoIV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(photoIV)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCollectionCell {
    private func initConstraints() {
        photoIV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
