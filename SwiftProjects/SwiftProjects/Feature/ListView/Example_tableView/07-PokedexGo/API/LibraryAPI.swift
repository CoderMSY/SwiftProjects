//
//  LibraryAPI.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit

class LibraryAPI: NSObject {
    static let sharedInstance = LibraryAPI()
    let persistencyManager = PersistencyManager()
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(_:)), name: Notification.Name(kNotification_downloadImage), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LibraryAPI {
    func getPokemons() -> [Pokemon] {
        return pokemons
    }
    
    @objc private func downloadImage(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let pokeImageView = userInfo["pokeImageView"] as? UIImageView
        let pokeImageUrl = userInfo["pokeImageUrl"] as? String
        
        guard let pokeImageView = pokeImageView else { return }
        guard let pokeImageUrl = pokeImageUrl else { return }
        
        let image = persistencyManager.getImage(pokeImageUrl)
        
        if let image = image {
            pokeImageView.image = image
        } else {
            DispatchQueue.global().async {
                let downloadedImage = self.downloadImg(pokeImageUrl)
                
                self.persistencyManager.saveImage(downloadedImage, fileUrlStr: pokeImageUrl)
                DispatchQueue.main.async {
                    pokeImageView.image = downloadedImage
                }
            }
        }
    }
    
    func downloadImg(_ urlStr: String) -> UIImage? {
        let url = URL(string: urlStr)
        
        guard let url = url else { return nil}
        
        let data = try? Data(contentsOf: url)
        guard let data = data else { return nil }
        
        let image = UIImage(data: data)
        
        return image
    }
}
