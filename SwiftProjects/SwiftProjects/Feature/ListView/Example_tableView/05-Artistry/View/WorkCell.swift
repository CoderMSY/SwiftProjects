//
//  WorkCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

class WorkCell: MSYBaseTableViewCell {
    
    lazy var workImageView: UIImageView = {
        var workImageView = UIImageView()
        return workImageView
    }()
    lazy var workTitleLabel: UILabel = {
        var workTitleLabel = UILabel()
        workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
        workTitleLabel.textAlignment = .center
        workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return workTitleLabel
    }()
    lazy var moreInfoTextView: UITextView = {
        var moreInfoTextView = UITextView()
        moreInfoTextView.textColor = UIColor(white: 114 / 255, alpha: 1)
        moreInfoTextView.isEditable = false
        moreInfoTextView.isScrollEnabled = false
//        moreInfoTextView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        moreInfoTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        return moreInfoTextView
    }()
    
    public let moreInfoText = "Select For More Info >"
    
    public var work: Work? {
        didSet {
            guard let work = work else {
                return
            }
            workImageView.image = work.image
            workTitleLabel.text = work.title
            moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
            moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(workImageView)
        contentView.addSubview(workTitleLabel)
        contentView.addSubview(moreInfoTextView)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorkCell {
    func initConstraints() {
        let marginTop = 15
        let margin = 20
        workImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(marginTop)
            make.leading.equalTo(contentView).offset(margin)
            make.trailing.equalTo(contentView).offset(-margin)
        }
        workTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(workImageView.snp.bottom).offset(marginTop)
            make.leading.equalTo(contentView).offset(margin)
            make.trailing.equalTo(contentView).offset(-margin)
        }
        moreInfoTextView.snp.makeConstraints { make in
            make.top.equalTo(workTitleLabel.snp.bottom).offset(marginTop)
            make.leading.equalTo(contentView).offset(margin)
            make.trailing.equalTo(contentView).offset(-margin)
            make.bottom.equalTo(contentView).offset(-marginTop)
        }
    }
}
