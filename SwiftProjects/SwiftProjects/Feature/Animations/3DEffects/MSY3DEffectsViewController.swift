//
//  MSY3DEffectsViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/2/17.
//

import UIKit

class MSY3DEffectsViewController: MSYBaseViewController {

    let effectsView = MSY3DEffectsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        msy_createCloseItem()
        initSubViews()
    }
    
}

extension MSY3DEffectsViewController {
    private func initSubViews() {
        view.addSubview(effectsView)
        effectsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        effectsView.start()
    }
}
