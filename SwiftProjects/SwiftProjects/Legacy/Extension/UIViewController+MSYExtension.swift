//
//  UIViewController+MSYExtension.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

extension UIViewController {
    func msy_createCloseItem() {
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closePage(_:)))
        navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc private func closePage(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
