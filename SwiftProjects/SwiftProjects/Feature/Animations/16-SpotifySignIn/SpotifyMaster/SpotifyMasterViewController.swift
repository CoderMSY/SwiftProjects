//
//  SpotifyMasterViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class SpotifyMasterViewController: VideoSplashViewController {

    lazy var logoImageView: UIImageView = {
        var logoImageView = UIImageView(image: UIImage(named: "login-secondary-logo"))
        return logoImageView
    }()
    lazy var logInBtn: UIButton = {
        var logInBtn = UIButton(type: .system)
        logInBtn.setTitle("LOG IN", for: .normal)
        logInBtn.setTitleColor(.white, for: .normal)
        logInBtn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0) ?? UIFont.boldSystemFont(ofSize: 16.0)
        logInBtn.backgroundColor = UIColor(r: 55, g: 55, b: 55, a: 1.0)
         
        return logInBtn
    }()
    lazy var signUpBtn: UIButton = {
        var signUpBtn = UIButton(type: .system)
        signUpBtn.setTitle("SIGN UP", for: .normal)
        signUpBtn.setTitleColor(.white, for: .normal)
        signUpBtn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0) ?? UIFont.boldSystemFont(ofSize: 16.0)
        signUpBtn.backgroundColor = UIColor(r: 23, g: 174, b: 4, a: 1.0)
         
        return signUpBtn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        msy_createCloseItem()
        initSubViews()
        setupVideoBackground()
    }

}

extension SpotifyMasterViewController {
    fileprivate func initSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(logInBtn)
        view.addSubview(signUpBtn)
        
        let margin_top = UIView.msy_statusHeight + 44.0 + 60
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(margin_top)
            make.centerX.equalToSuperview()
        }
        let margin_bottom = UIView.msy_safeAreaBottom
        logInBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-margin_bottom)
            make.trailing.equalTo(view.snp.centerX)
            make.height.equalTo(80)
        }
        signUpBtn.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.centerX)
            make.bottom.height.equalTo(logInBtn)
            make.trailing.equalToSuperview()
        }
    }
    
    fileprivate func setupVideoBackground() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.isUserInteractionEnabled = false
    }
}
