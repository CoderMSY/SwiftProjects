//
//  MSYBaseTableViewCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit

class MSYBaseTableViewCell: UITableViewCell {
    
    class var cellReuseId: String {
        return String(describing: self)
    }
    
//    class func cellReuseId() -> String {
//        let reuseId = String(describing: self)
//
//        return reuseId
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.contentView.backgroundColor = UIColor.systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
