//
//  PersistencyManager.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/6.
//

import UIKit

class PersistencyManager: NSObject {
    func saveImage(_ image: UIImage?, fileUrlStr: String?) {
        guard let image = image else { return }
        guard let fileUrlStr = fileUrlStr else { return }
        
        let fileName = URL(string: fileUrlStr)?.lastPathComponent
        
        let path = NSHomeDirectory() + "/Documents/\(String(describing: fileName))"
        let data = image.pngData()
        try? data?.write(to: URL(fileURLWithPath: path), options: Data.WritingOptions.atomic)
    }
    
    func getImage(_ fileUrlStr: String?) -> UIImage? {
        guard let fileUrlStr = fileUrlStr else { return nil }
        
        let fileName = URL(string: fileUrlStr)?.lastPathComponent
        
        let path = NSHomeDirectory() + "/Documents/\(String(describing: fileName))"
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.uncached)
            return UIImage(data: data)
        } catch {
            return nil
        }
        
    }
}
