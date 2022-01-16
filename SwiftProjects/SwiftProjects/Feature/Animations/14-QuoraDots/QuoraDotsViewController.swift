//
//  QuoraDotsViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class QuoraDotsViewController: MSYBaseViewController {

    lazy var logoImageView: UIImageView = {
        var logoImageView = UIImageView(image: UIImage(named: "logo"))
        return logoImageView
    }()
    lazy var dotOne: UIImageView = {
        var dotOne = UIImageView(image: UIImage(named: "dot"))
        return dotOne
    }()
    lazy var dotTwo: UIImageView = {
        var dotTwo = UIImageView(image: UIImage(named: "dot"))
        return dotTwo
    }()
    lazy var dotThree: UIImageView = {
        var dotThree = UIImageView(image: UIImage(named: "dot"))
        return dotThree
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCloseItem()
        initSubViews()
        startAnimation()
    }
    private func initSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(dotOne)
        view.addSubview(dotTwo)
        view.addSubview(dotThree)
        
        let top = UIView.msy_statusHeight + 44.0 + 100.0
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.centerX.equalToSuperview()
        }
        dotOne.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(17.0)
            make.trailing.equalTo(dotTwo.snp.leading).offset(-10.0)
            make.size.equalTo(30.0)
        }
        dotTwo.snp.makeConstraints { make in
            make.top.size.equalTo(dotOne)
            make.centerX.equalTo(logoImageView)
        }
        dotThree.snp.makeConstraints { make in
            make.top.size.equalTo(dotOne)
            make.leading.equalTo(dotTwo.snp.trailing).offset(10)
        }
    }

}

extension QuoraDotsViewController {
    private func startAnimation() {
        dotOne.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotTwo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotThree.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        let duration = 0.6
        UIView.animate(withDuration: duration, delay: 0.0, options: [.repeat, UIView.AnimationOptions.autoreverse], animations: {
            self.dotOne.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.dotTwo.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.dotThree.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
