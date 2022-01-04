//
//  GoodAsOldPhonesTabBarCtr.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import Foundation
import UIKit

class GoodAsOldPhonesTabBarCtrConfig: NSObject {
    lazy var tabBarCtr: UITabBarController = {
        let tabBarCtr = UITabBarController()
        tabBarCtr.viewControllers = viewCtrs()
        
        return tabBarCtr
    }()
    
    override init() {
        super.init()
    }
    
    private func viewCtrs() -> [UINavigationController] {
        let productCtr = ProductListViewController()
        let productNavCtr = MSYNavigationController.init(rootViewController: productCtr)
        let productItem = getTabBarItem(title: "products", imgName: "tabbar_home", selectedImgName: "tabbar_home_selected")
        productNavCtr.tabBarItem = productItem;
        
        let contactCtr = ContactViewController()
        let contactNavCtr = MSYNavigationController.init(rootViewController: contactCtr)
        let contactItem = getTabBarItem(title: "contact", imgName: "tabbar_mine", selectedImgName: "tabbar_mine_selected")
        contactNavCtr.tabBarItem = contactItem
        
        let viewCtrs = [productNavCtr, contactNavCtr]
        
        return viewCtrs
    }
}

extension GoodAsOldPhonesTabBarCtrConfig {
    private func getTabBarItem(title: String, imgName: String, selectedImgName: String) -> UITabBarItem {
        let image = UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal);
        let selectedImage = UIImage(named: selectedImgName)?.withRenderingMode(.alwaysOriginal);
        
        let tabBarItem = UITabBarItem.init(title: title, image: image, selectedImage: selectedImage)
        
        return tabBarItem
    }
}
