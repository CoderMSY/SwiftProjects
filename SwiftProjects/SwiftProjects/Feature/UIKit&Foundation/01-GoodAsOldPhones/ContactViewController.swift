//
//  ContactViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import Foundation
import UIKit

class ContactViewController: MSYBaseViewController {
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        title = "联系人"
        var frame: CGRect
        if #available(iOS 11.0, *) {
            frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        } else {
            frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.width, height: view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length)
        }
        
        scrollView.frame = frame
        view.addSubview(scrollView)
        
        initSubView()
        
        
    }
}

extension ContactViewController {
    private func initSubView() -> Void {
        let scale = UIScreen.main.bounds.size.width / 750
        let headerIV = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: scale * 250))
        headerIV.image = UIImage(named: "header-contact")
        scrollView.addSubview(headerIV)
        
        let titleLab_x: CGFloat = 15.0
        var y: CGFloat = headerIV.frame.maxY + 20
        let titleLab_w = view.frame.width - titleLab_x * 2
        let titleLab = getTitleLab(text: "About Us", x: titleLab_x, y: y, width: titleLab_w)
        scrollView.addSubview(titleLab)
        
        let content1 = "Good as Old Phones returns the phones of  yesteryear back to their original glory and then gets them into the hands* of those who appreciate them most:"
        let contentLab_x: CGFloat = 60.0
        y = titleLab.frame.maxY + 10;
        let contentLab_w = view.frame.width - contentLab_x * 2
        let contentLab1 = getContentLab(text: content1, x: contentLab_x, y: y, width: contentLab_w)
        scrollView.addSubview(contentLab1)
        
        let content2 = "Whether you are looking for a turn-of-the-century wall set or a Zack Morris Special, we've got you covered. Give us a ring, and we will get you connected. "
        y = contentLab1.frame.maxY + 10;
        let contentLab2 = getContentLab(text: content2, x: contentLab_x, y: y, width: contentLab_w)
        scrollView.addSubview(contentLab2)
        
        y = contentLab2.frame.maxY + 20
        let titleLab2 = getTitleLab(text: "Contact", x: titleLab_x, y: y, width: titleLab_w)
        scrollView.addSubview(titleLab2)
        
        let iconDetailList: [[String: String]] = [
            ["icon": "icon-about-email", "detail": "good-as-old@example.com"],
            ["icon" : "icon-about-phone", "detail" : "412-888-9028"],
            ["icon" : "icon-about-website", "detail" : "www.example.com"]
        ]
        
        var lastView: UIView = titleLab2
        for dic in iconDetailList {
            y = lastView.frame.maxY + 10;
            let iconDetailView = getIconDetailView(iconName: dic["icon"], detail: dic["detail"], y: y)
            scrollView.addSubview(iconDetailView)
            
            lastView = iconDetailView
        }
        
        y = lastView.frame.maxY + 20
        let titleLab3 = getTitleLab(text: "just so so", x: titleLab_x, y: y, width: titleLab_w)
        scrollView.addSubview(titleLab3)
    }
    
    private func getTitleLab(text: String, x: CGFloat, y: CGFloat, width: CGFloat) -> UILabel {
        let font: UIFont = UIFont.boldSystemFont(ofSize: 20)
        let normalText: NSString = text as NSString
        let attDic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let textSize: CGSize = normalText.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attDic as? [NSAttributedString.Key : Any], context: nil).size
        
        let titleLab = UILabel(frame: CGRect(x: x, y: y, width: width, height: textSize.height))
        titleLab.font = font
        titleLab.text = text
        titleLab.textAlignment = NSTextAlignment.center
        titleLab.numberOfLines = 0
        
        return titleLab
    }
    
    private func getContentLab(text: String, x: CGFloat, y: CGFloat, width: CGFloat) -> UILabel {
        let font: UIFont = UIFont.systemFont(ofSize: 16)
        let normalText: NSString = text as NSString
        let attDic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let textSize: CGSize = normalText.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attDic as? [NSAttributedString.Key : Any], context: nil).size
        
        let titleLab = UILabel(frame: CGRect(x: x, y: y, width: width, height: textSize.height))
        titleLab.font = font
        titleLab.text = text
        titleLab.textAlignment = NSTextAlignment.left
        titleLab.numberOfLines = 0
        
        return titleLab
    }
    
    private func getIconDetailView(iconName: String?, detail: String?, y: CGFloat) -> UIView {
        let detailView: UIView = UIView(frame: CGRect(x: 30, y: y, width: view.frame.width - 30 * 2, height: 60))
        
        let iconIV = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40));
        if let iconName = iconName {
            iconIV.image = UIImage(named: iconName);
        }
        detailView.addSubview(iconIV)
        
        
        let detailLab_x = iconIV.frame.maxX + 15
        let detailLab_w = detailView.frame.width - detailLab_x
        let detailLab = UILabel(frame: CGRect(x: detailLab_x, y: 10, width: detailLab_w, height: 40))
        detailLab.text = detail
        detailView.addSubview(detailLab)
        
        return detailView
    }
}
