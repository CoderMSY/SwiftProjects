//
//  SnapMainViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class SnapMainViewController: MSYBaseViewController {

    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        createCloseItem()
        initSubviews()
    }
}

extension SnapMainViewController {
    fileprivate func initSubviews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let chatCtr = SnapChatViewController()
        let storiesCtr = SnapStoriesViewController()
        let discoverCtr = SnapDiscoverViewController()
        add(childViewController: chatCtr, toParentViewController: self)
        add(childViewController: storiesCtr, toParentViewController: self)
        add(childViewController: discoverCtr, toParentViewController: self)
        
        /// Set up current snap view.
        let cameraImageView = createImageView(imageName: "snap_camera")
        changeX(ofView: cameraImageView, xPosition: view.frame.width)
        scrollView.addSubview(cameraImageView)
        
        /// Move stories and discover view to the right screen.
//        changeX(ofView: chatCtr.view, xPosition: -view.frame.width)
        changeX(ofView: storiesCtr.view, xPosition: view.frame.width * 2)
        changeX(ofView: discoverCtr.view, xPosition: view.frame.width * 3)
        
        /// Set up contentSize and contentOffset.
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: 0)
        scrollView.contentOffset.x = view.frame.width
    }
    
    fileprivate func changeX(ofView currentView: UIView, xPosition: CGFloat) {
        var frame = view.frame
        frame.origin.x = xPosition
        frame.size.height = frame.size.height - UIView.msy_safeAreaBottom - UIView.msy_statusHeight - 44.0
        currentView.frame = frame
    }
    
    fileprivate func add(childViewController: UIViewController, toParentViewController parentViewController: UIViewController) {
        //添加一个 childViewController
        //添加到父控制器中
        addChild(childViewController)
        //把子控制器的 view 添加到父控制器的 view 上面
        scrollView.addSubview(childViewController.view)
        //子控制器被通知有了一个父控制器
        childViewController.didMove(toParent: parentViewController)
    }
    //移除一个 childViewController
    /*
    fileprivate func removeChildViewController(childViewController: UIViewController) {
        //子控制器被通知即将解除父子关系
        childViewController.willMove(toParent: self)
        //把子控制器的 view 从到父控制器的 view 上面移除
        childViewController.view.removeFromSuperview()
        //真正的解除关系,内部会调用childViewController.didMove(toParent: nil)
        childViewController.removeFromParent()
    }
     */
}
