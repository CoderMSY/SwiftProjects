//
//  TDItemCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

class TDItemCell: UITableViewCell {
    lazy var titleLab: UILabel = {
        var titleLab = UILabel()
        titleLab.textAlignment = .center
        return titleLab
    }()
    
    lazy var locationLab: UILabel = {
        var locationLab = UILabel()
        locationLab.textAlignment = NSTextAlignment.center
        return locationLab
    }()
    
    lazy var dateLab: UILabel = {
        var dateLab = UILabel()
        dateLab.textAlignment = .center
        return dateLab
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(locationLab)
        contentView.addSubview(dateLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lab_w = frame.size.width / 3
        let lab_h = frame.size.height
        var lab_x: CGFloat = 0.0
        titleLab.frame = CGRect(x: lab_x, y: 0, width: lab_w, height: lab_h)
        lab_x = titleLab.frame.maxX
        locationLab.frame = CGRect(x: lab_x, y: 0, width: lab_w, height: lab_h)
        lab_x = locationLab.frame.maxX
        dateLab.frame = CGRect(x: lab_x, y: 0, width: lab_w, height: lab_h)
    }
    
    func configCell(with item: TDItem, isChecked: Bool = false) {
        if isChecked {
            let attributedStr = NSAttributedString(string: item.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            
            titleLab.attributedText = attributedStr
            locationLab.text = nil
            dateLab.text = nil
        } else {
            titleLab.text = item.title
            
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLab.text = dateFormatter.string(from: date)
            }
            
            if let location = item.location {
                locationLab.text = location.name
            }
        }
    }
}
