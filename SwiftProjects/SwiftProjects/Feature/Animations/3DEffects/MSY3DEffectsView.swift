//
//  MSY3DEffectsView.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/2/17.
//

import UIKit
import CoreMotion

class MSY3DEffectsView: UIView {

    var maxOffset: CGFloat = 30.0
    var lastGravityX: Double = 0, lastGravityY: Double = 0
    var deviceMotionUpdateInterval: TimeInterval = 1 / 40.0
    
    var frontImageViewCenter: CGPoint = .zero
    var backImageViewCenter: CGPoint = .zero
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
        manager.deviceMotionUpdateInterval = deviceMotionUpdateInterval
        return manager
    }()
    
    lazy var frontImageView: UIImageView = {
        var frontImageView = UIImageView()
        frontImageView.contentMode = .scaleAspectFill
        frontImageView.image = UIImage(named: "frontImage")
        
        return frontImageView
    }()
    
    lazy var middleImageView: UIImageView = {
        var middleImageView = UIImageView()
        middleImageView.contentMode = .scaleAspectFill
        middleImageView.image = UIImage(named: "middleImage")
        return middleImageView
    }()
    
    lazy var backImageView: UIImageView = {
        var backImageView = UIImageView()
        backImageView.contentMode = .scaleAspectFill
        backImageView.image = UIImage(named: "backImage")
        return backImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backImageViewCenter = center
        frontImageViewCenter = center
    }
    
    func start() {
        startMotion()
    }
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
}

extension MSY3DEffectsView {
    private func setUpSubView() {
        addSubview(backImageView)
        addSubview(middleImageView)
        addSubview(frontImageView)
        
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(maxOffset * 2)
            make.height.equalToSuperview().offset(maxOffset * 2)
        }
        middleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        frontImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(maxOffset * 2)
            make.height.equalToSuperview().offset(maxOffset * 2)
        }
    }
    
    private func startMotion() {
        guard motionManager.isDeviceMotionAvailable else {
            return
        }
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] deviceMotion, error in
            guard let motion = deviceMotion else { return }
            
//            print("x: \(motion.gravity.x) y: \(motion.gravity.y) z: \(motion.gravity.z)")
            
            self?.update(gravityX: motion.gravity.x,
                         gravityY: motion.gravity.y,
                         gravityZ: motion.gravity.z)
        }
    }
    
    private func update(gravityX: Double,
                        gravityY: Double,
                        gravityZ: Double) {
        let timeInterval = sqrt(pow((gravityX - lastGravityX), 2) + pow((gravityY - lastGravityY), 2)) * deviceMotionUpdateInterval
//        print("timeInterval: \(timeInterval)")
        let animationKey = "positionAnimation"
        
        let newBackImageViewCenter = CGPoint(x: self.center.x + gravityX * maxOffset,
                                             y: self.center.y + gravityY * maxOffset)
//        print("newBackImageViewCenter: \(newBackImageViewCenter)")
        let backIVAnimation = CABasicAnimation(keyPath: "position")
        backIVAnimation.fromValue = NSValue(cgPoint: self.backImageViewCenter)
        backIVAnimation.toValue = NSValue(cgPoint: newBackImageViewCenter)
        backIVAnimation.duration = timeInterval
        backIVAnimation.fillMode = .forwards
        backIVAnimation.isRemovedOnCompletion = false
        
        backImageView.layer.removeAnimation(forKey: animationKey)
        backImageView.layer.add(backIVAnimation, forKey: animationKey)
        
        let newFrontImageViewCenter = CGPoint(x: self.center.x - gravityX * maxOffset,
                                              y: self.center.y - gravityY * maxOffset)
//        print("newFrontImageViewCenter: \(newFrontImageViewCenter)")
        let frontIVAnimation = CABasicAnimation(keyPath: "position")
        frontIVAnimation.fromValue = NSValue(cgPoint: self.frontImageViewCenter)
        frontIVAnimation.toValue = NSValue(cgPoint: newFrontImageViewCenter)
        frontIVAnimation.duration = timeInterval
        frontIVAnimation.fillMode = .forwards
        frontIVAnimation.isRemovedOnCompletion = false
        
        frontImageView.layer.removeAnimation(forKey: animationKey)
        frontImageView.layer.add(frontIVAnimation, forKey: animationKey)
        
        self.backImageViewCenter = newBackImageViewCenter
        self.frontImageViewCenter = newFrontImageViewCenter
    }
    
}
