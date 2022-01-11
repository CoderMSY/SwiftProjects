//
//  CandyDetailViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/5.
//

import UIKit

class CandyDetailViewController: MSYBaseViewController {
    lazy var detailLabel: UILabel = {
        var detailLabel = UILabel()
        return detailLabel
    }()
    
    lazy var candyImageView: UIImageView = {
        var candyImageView = UIImageView()
        candyImageView.contentMode = .scaleAspectFit
        return candyImageView
    }()
    
    var selectedCandy: Candy? {
        didSet {
            guard let selectedCandy = selectedCandy else {
                return
            }
            
            title = selectedCandy.category
            
            detailLabel.text = selectedCandy.name
            candyImageView.image = UIImage(named: selectedCandy.name)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(detailLabel)
        view.addSubview(candyImageView)
        initConstraints()
    }
}

extension CandyDetailViewController {
    private func initConstraints() {
//        let marginTop = UIView.msy_statusHeight + (navigationController?.navigationBar.bounds.size.height ?? 0)
        let marginTop = UIView.msy_statusHeight + UIView.msy_navBarHeight
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(marginTop)
            make.leading.greaterThanOrEqualToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
        
        candyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
}
