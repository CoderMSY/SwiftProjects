//
//  AnnotatedPhotoCell.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/10.
//

import UIKit

class AnnotatedPhotoCell: MSYBaseCollectionViewCell {
    lazy var cornersView: RoundedCornersView = {
        var cornersView = RoundedCornersView()
        
        return cornersView
    }()
    var photo: PhotoItem? {
        didSet {
            guard let photo = photo else { return }
            cornersView.imageView.image = photo.image
            cornersView.captionLabel.text = photo.caption
            cornersView.commentLabel.text = photo.comment
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cornersView)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnnotatedPhotoCell {
    private func initConstraints() {
        cornersView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            cornersView.imageView.snp.updateConstraints { make in
                make.height.equalTo(attributes.photoHeight)
            }
        }
    }
}
