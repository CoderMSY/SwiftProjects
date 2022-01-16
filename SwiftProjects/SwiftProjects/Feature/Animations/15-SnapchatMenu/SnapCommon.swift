//
//  SnapCommon.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

func createImageView(imageName: String) -> UIImageView {
    let imageView = UIImageView(image: UIImage(named: imageName))
    imageView.contentMode = .scaleToFill
    
    return imageView
}
