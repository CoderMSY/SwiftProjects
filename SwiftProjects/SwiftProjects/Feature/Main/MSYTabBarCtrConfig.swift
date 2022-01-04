//
//  MSYTabBarCtrConfig.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/28.
//

import Foundation
import CYLTabBarController

class MSYTabBarCtrConfig: NSObject {
    lazy var tabBarCtr: UITabBarController? = {
        let tabBarCtr = CYLTabBarController(viewControllers: viewCtrs(), tabBarItemsAttributes: tabBarItemsAttributes())
        
        return tabBarCtr
    }()
    
    override init() {
        super.init()
        
        tabBarCtr?.delegate = self
        let selectIndex = UserDefaults.standard.object(forKey: "kUD_selectTabBarIndex")
        if let index = selectIndex as? Int  {
            tabBarCtr?.selectedIndex = index
        }
    }
    
    func viewCtrs() -> [UINavigationController] {
        let discovery = MSYNavigationController(rootViewController: MSYKitFoundationViewController());
        let podcast = MSYNavigationController(rootViewController: MSYListViewController());
        let mine = MSYNavigationController(rootViewController: UIViewController());
        let follow = MSYNavigationController(rootViewController: UIViewController());
        let cloudVillage = MSYNavigationController(rootViewController: UIViewController());
        
        let viewCtrs = [discovery, podcast, mine, follow, cloudVillage]
        
        return viewCtrs
    }
    
    func tabBarItemsAttributes() -> [[String : String]] {
        let itemOne = [
            CYLTabBarItemTitle: "UIKit",
            CYLTabBarItemImage: "tb_uikit",
            CYLTabBarItemSelectedImage: "tb_uikit_selected"
        ]
        let itemTwo = [
            CYLTabBarItemTitle: "listView",
            CYLTabBarItemImage: "tb_listView",
            CYLTabBarItemSelectedImage: "tb_listView_selected"
        ]
        let itemThree = [
            CYLTabBarItemTitle: "animation",
            CYLTabBarItemImage: "tb_animation",
            CYLTabBarItemSelectedImage: "tb_animation_selected"
        ]
        let itemFour = [
            CYLTabBarItemTitle: "library",
            CYLTabBarItemImage: "tb_library",
            CYLTabBarItemSelectedImage: "tb_library_selected"
        ]
//        let itemFive = [
//            CYLTabBarItemTitle: "open source",
//            CYLTabBarItemImage: "tb_openSource",
//            CYLTabBarItemSelectedImage: "tb_openSource_selected"
//        ]
        let itemFive = [
            CYLTabBarItemTitle: "design pattern",
            CYLTabBarItemImage: "tb_designPattern",
            CYLTabBarItemSelectedImage: "tb_designPattern_selected"
        ]
        
        let itemsAtt = [itemOne, itemTwo, itemThree, itemFour, itemFive]
        
        return itemsAtt
    }
}

extension MSYTabBarCtrConfig: CYLTabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect control: UIControl) {
        UserDefaults.standard.set(tabBarController.selectedIndex, forKey: "kUD_selectTabBarIndex")
        UserDefaults.standard.synchronize()
    }
}

