//
//  PhotoStreamViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/10.
//

import UIKit
import AVFoundation

class PhotoStreamViewController: MSYBaseViewController {

    lazy var flowLayout: PinterestLayout = {
        let flowLayout = PinterestLayout()
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 6.0)
        collectionView.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: AnnotatedPhotoCell.cellReuseId)
        
        return collectionView
    }()
    
    var photos = PhotoItem.allPhotos()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCloseItem()
        flowLayout.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

extension PhotoStreamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnotatedPhotoCell.cellReuseId, for: indexPath) as! AnnotatedPhotoCell
        cell.photo = photos[indexPath.row]
        
        return cell
    }
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let photo = photos[(indexPath as NSIndexPath).item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
        
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        let photo = photos[(indexPath as NSIndexPath).item]
//        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let font = UIFont.systemFont(ofSize: 10)
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        
        return height
    }
}
