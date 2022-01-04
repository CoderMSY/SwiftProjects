//
//  ProductViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import UIKit

class ProductViewController: UIViewController {
    var product: Product?
    
    private lazy var bgIV: UIImageView = {
        var bgIV = UIImageView()
        bgIV.frame = view.frame
        bgIV.contentMode = .scaleAspectFill
        return bgIV
    }()
    
    private lazy var titleLab: UILabel = {
        var titleLab = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40))
        return titleLab
    }()
    
    private lazy var addShopCarBtn: UIButton = {
        var addShopCarBtn = UIButton(type: .custom)
        addShopCarBtn.setImage(UIImage(named: "button-addtocart"), for: .normal)
        addShopCarBtn.frame = CGRect(x: (view.frame.width - 317.0 / 2) / 2, y: titleLab.frame.maxY + 20, width: 317.0 / 2, height: 41)
        addShopCarBtn.addTarget(self, action: #selector(addShopCarBtnClicked), for: .touchUpInside)
        return addShopCarBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        if let bgImageName = product?.fullscreenImageName {
            view.addSubview(bgIV)
            
            bgIV.image = UIImage(named: bgImageName)
        }
        
        view.addSubview(titleLab)
        titleLab.text = product?.name
        
        view.addSubview(addShopCarBtn)
    }
    
    @objc func addShopCarBtnClicked(button: UIButton) {
        debugPrint("add shop car is \(String(describing: product?.name))")
    }
}

