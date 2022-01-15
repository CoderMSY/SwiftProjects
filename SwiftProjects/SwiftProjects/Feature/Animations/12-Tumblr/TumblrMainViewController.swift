//
//  TumblrMainViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/14.
//

import UIKit

class TumblrMainViewController: MSYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createCloseItem()
        configToolbarItems()
        view.backgroundColor = UIColor(r: 0, g: 64, b: 128, a: 1.0)
    }
    
    private func configToolbarItems() {
        navigationController?.setToolbarHidden(false, animated: true)
        if #available(iOS 15.0, *) {
            let appearance = UIToolbarAppearance()
            appearance.backgroundColor = .black
            navigationController?.toolbar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.toolbar.barStyle = .black
            navigationController?.toolbar.barTintColor =  .black
        }
        navigationController?.toolbar.tintColor = .white
        
        
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemClicked(_:)))
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        setToolbarItems([searchItem, flexibleSpace, addItem, flexibleSpace, refreshItem], animated: true)
    }
}

extension TumblrMainViewController {
    @objc func addItemClicked(_ sender: UIBarButtonItem) {
        let ctr = TumblrMenuViewController()
        ctr.modalPresentationStyle = .fullScreen
        self.present(ctr, animated: true, completion: nil)
    }
}
