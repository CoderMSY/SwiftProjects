//
//  PhotoItem.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/10.
//

import UIKit

class PhotoItem {
    class func allPhotos() -> [PhotoItem] {
        var photos = [PhotoItem]()
        if let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist") {
            if let photosFromPlist = NSArray(contentsOf: URL) {
                for dictionary in photosFromPlist {
                    let photo = PhotoItem(dictionary: dictionary as! NSDictionary)
                    photos.append(photo)
                }
            }
        }
        return photos
    }
    
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary) {
        let caption = dictionary["Caption"] as? String
        let comment = dictionary["Comment"] as? String
        let photo = dictionary["Photo"] as? String
        let image = UIImage(named: photo!)?.decompressedImage
        self.init(caption: caption!, comment: comment!, image: image!)
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: comment).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
}
