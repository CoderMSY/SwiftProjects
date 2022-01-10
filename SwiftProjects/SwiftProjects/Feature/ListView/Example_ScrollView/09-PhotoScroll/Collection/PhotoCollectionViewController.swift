//
//  PhotoCollectionViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/7.
//

import UIKit

class PhotoCollectionViewController: MSYBaseViewController {
    
    fileprivate let thumbnailSize:CGFloat = 70.0
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize =
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.cellReuseId)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCloseItem()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        initConstraints()
    }
}

extension PhotoCollectionViewController {
    private func initConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.cellReuseId, for: indexPath) as! PhotoCollectionCell
        let fullSizedImage = UIImage(named:photos[indexPath.row])
        cell.photoIV.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ctr = PhotoPageViewController()
        ctr.photos = photos
        ctr.currentIndex = indexPath.row
        
        navigationController?.pushViewController(ctr, animated: true)
        
    }
}
