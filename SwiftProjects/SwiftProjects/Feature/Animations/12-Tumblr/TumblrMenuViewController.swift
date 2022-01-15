//
//  TumblrMenuViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/15.
//

import UIKit

class TumblrMenuViewController: MSYBaseViewController {

    var itemViewList: [TumblrMenuItemView] = []
    lazy var dismissBtn: UIButton = {
        var dismissBtn = UIButton(type: .custom)
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.setTitleColor(.white, for: .normal)
        dismissBtn.addTarget(self, action: #selector(closePage(_:)), for: .touchUpInside)
        
        return dismissBtn
    }()
    
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 53, g: 53, b: 53, a: 1.0)
        self.transitioningDelegate = self.transitionManager
        initSubViews()
    }
    

    private func initSubViews() {
        let key_image = "image"
        let key_title = "title"
        let infoDicList = [
            [key_image : "Text", key_title : "Text"],
            [key_image : "Photo", key_title : "Photo"],
            [key_image : "Quote", key_title : "Quote"],
            [key_image : "Link", key_title : "Link"],
            [key_image : "Chat", key_title : "Chat"],
            [key_image : "Audio", key_title : "Audio"]
        ]
        for infoDic in infoDicList {
            let image = infoDic[key_image]
            let title = infoDic[key_title]
            let itemView = TumblrMenuItemView(frame: .zero, imageName: image!, title: title!)
            
            view.addSubview(itemView)
            itemViewList.append(itemView)
        }
        
        let margin_top = UIView.msy_statusHeight + (self.navigationController?.navigationBar.bounds.height ?? 44.0)
        var lastItemView: TumblrMenuItemView?
        for itemView in itemViewList {
            let index = itemViewList.firstIndex(of: itemView) ?? 0
            let isOdd = index % 2 != 0
            
            itemView.snp.makeConstraints { make in
                if index == 0 || index == 1 {
                    make.top.equalToSuperview().offset(margin_top)
                } else {
                    if let lastItemView = lastItemView {
                        if isOdd {
                            make.top.equalTo(lastItemView)
                        } else {
                            make.top.equalTo(lastItemView.snp.bottom).offset(20)
                        }
                    }
                }
                if isOdd {
                    make.leading.equalTo(self.view.snp.centerX).offset(20)
                } else {
                    make.trailing.equalTo(self.view.snp.centerX).offset(-20)
                }
                
                make.width.equalTo(100)
                make.height.equalTo(130)
                
                
            }
            
            lastItemView = itemView
        }
        
        view.addSubview(dismissBtn)
        let margin_bottom = UIView.msy_safeAreaBottom
        dismissBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-margin_bottom - 30)
        }
    }

    @objc private func closePage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
