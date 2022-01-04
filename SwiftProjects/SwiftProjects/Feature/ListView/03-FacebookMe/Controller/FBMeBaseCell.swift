//
//  FBMeBaseCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit

class FBMeBaseCell: UITableViewCell {
    class var cellReuseId: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = FBSpecs.color.white
        textLabel?.textColor = FBSpecs.color.black
        textLabel?.font = FBSpecs.font.large
        
        detailTextLabel?.font = FBSpecs.font.small
        detailTextLabel?.textColor = FBSpecs.color.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
