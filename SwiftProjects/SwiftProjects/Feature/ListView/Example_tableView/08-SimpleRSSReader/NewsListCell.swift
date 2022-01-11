//
//  NewsListCell.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit
//import Masonry

enum CellState {
  case expanded
  case collapsed
}

class NewsListCell: MSYBaseTableViewCell {
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 25.0) ?? UIFont.boldSystemFont(ofSize: 25.0)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .darkText
//        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        return titleLabel
    }()
    lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Avenir-Light", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        dateLabel.textColor = .darkGray
        return dateLabel
    }()
    lazy var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        descriptionLabel.textColor = .darkText
        descriptionLabel.numberOfLines = 4
        return descriptionLabel
    }()
    
    var item: (title: String, description: String, pubDate: String)? {
        didSet {
            guard let item = item else { return }
            (titleLabel.text, dateLabel.text, descriptionLabel.text) = (item.title, item.pubDate, item.description)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsListCell {
    private func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-10).priority(.low)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
//    private func initMasonryConstraints() {
//        titleLabel.mas_makeConstraints { (make) in
//            make?.top.mas_equalTo()(self.contentView)?.offset()(10)
//            make?.leading.mas_equalTo()(self.contentView)?.offset()(20)
//            make?.trailing.mas_lessThanOrEqualTo()(self.contentView)?.offset()(-20)
//        }
//        dateLabel.mas_makeConstraints { (make) in
//            make?.top.mas_equalTo()(self.titleLabel.mas_bottom)?.offset()(1)
//            make?.leading.mas_equalTo()(self.titleLabel)
//            make?.trailing.mas_lessThanOrEqualTo()(self.contentView)?.offset()(-20)
//        }
//        descriptionLabel.mas_makeConstraints { (make) in
//            make?.top.mas_equalTo()(self.dateLabel.mas_bottom)?.offset()(2)
//            make?.leading.mas_equalTo()(self.titleLabel)
//            make?.bottom.mas_lessThanOrEqualTo()(self.contentView)?.offset()(-10)
//            make?.trailing.mas_lessThanOrEqualTo()(self.contentView)?.offset()(-20)
//        }
//    }
}
