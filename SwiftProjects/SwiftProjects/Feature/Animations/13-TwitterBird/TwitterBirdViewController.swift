//
//  TwitterBirdViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class TwitterBirdViewController: MSYBaseViewController {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "twitterScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.mask = maskLayer
        
        return imageView
    }()
    lazy var maskLayer: CALayer = {
        var maskLayer = CALayer()
        maskLayer.contents = UIImage(named: "twitterBird")?.cgImage
        maskLayer.position = view.center
        maskLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        
        return maskLayer
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
        createCloseItem()
        
        imageView.frame = view.frame
        view.addSubview(imageView)
        
        animateMask()
    }
    
}

extension TwitterBirdViewController {
    private func animateMask() {
        // init key frame animation
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        
        // animate zoom in and then zoom out
        let initalBounds = NSValue(cgRect: maskLayer.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 64))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        
        // set up time interals
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        
        // add animation to current view
        keyFrameAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        ]
        maskLayer.add(keyFrameAnimation, forKey: "bounds")
    }
}

extension TwitterBirdViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.layer.mask = nil
    }
}
