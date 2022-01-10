//
//  InterestsViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/10.
//

import UIKit

class InterestsViewController: MSYBaseViewController {

    fileprivate var interests = Interest.createInterests()
    
    lazy var bgImageView: UIImageView = {
        var bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "r1")
        return bgImageView
    }()
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = UIScreen.main.bounds
        
        return visualEffectView
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let margin = 30.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: SCREEN_WIDTH - margin * 2, height: SCREEN_HEIGHT * 0.6)
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = margin
        
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
//        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        collectionView.register(InterestsCollectionViewCell.self, forCellWithReuseIdentifier: InterestsCollectionViewCell.cellReuseId)
        return collectionView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        createCloseItem()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(bgImageView)
        view.addSubview(visualEffectView)
        view.addSubview(collectionView)
        
        initConstraints()
    }

}

extension InterestsViewController {
    private func setBgImage() {
        let bgImage = UIImage(named: "r1")
//        view.setBackgroundImage(  , for: UIControl.State)
    }
    private func initConstraints() {
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InterestsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.cellReuseId, for: indexPath) as! InterestsCollectionViewCell
        cell.interest = interests[indexPath.row]
        
        return cell
    }
}

extension InterestsViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //
    }
}
