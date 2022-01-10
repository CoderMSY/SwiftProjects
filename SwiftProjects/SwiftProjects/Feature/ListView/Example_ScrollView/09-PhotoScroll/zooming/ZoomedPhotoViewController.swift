//
//  ZoomedPhotoViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/7.
//

import UIKit

class ZoomedPhotoViewController: MSYBaseViewController {
    private let MinScale = 1.0
    private let MaxScale = 4.0
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.minimumZoomScale = MinScale
        scrollView.maximumZoomScale = MaxScale
        scrollView.backgroundColor = .black
        
        return scrollView
    }()
    
    private var currentSize: CGSize = .zero;
    
    var currentImage: UIImage? {
        didSet {
            guard let currentImage = currentImage else { return }
            
            layoutImageView()
            imageView.image = currentImage
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSize = view.bounds.size
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(self.imageView)
        // 添加图片双击放大手势
        addTapGesture()
    }
}

extension ZoomedPhotoViewController {
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //屏幕翻转时的size
        currentSize = size
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var browserFrame = CGRect.zero
        if currentSize.width > currentSize.height {
            let browserY = UIView.msy_statusHeight + (navigationController?.navigationBar.bounds.height ?? 0)
            browserFrame = CGRect(x: 0, y: browserY, width: currentSize.width, height: currentSize.height - browserY)
        } else {
            let browserY = UIView.msy_statusHeight + (navigationController?.navigationBar.bounds.height ?? 0)
            browserFrame = CGRect(x: 0, y: browserY, width: currentSize.width, height: currentSize.height - browserY)
        }
        
        scrollView.frame = browserFrame
        layoutImageView()
    }
}

extension ZoomedPhotoViewController {
    private func addTapGesture() {
        let doubleClick = UITapGestureRecognizer(target: self, action: #selector(doubleClicked(sender:)))
        scrollView.addGestureRecognizer(doubleClick)
    }
    @objc private func doubleClicked(sender: UITapGestureRecognizer) {
        if scrollView.zoomScale > MinScale {
            scrollView.setZoomScale(MinScale, animated: true)
        } else {
            let touchPoint = sender.location(in: imageView)
            let newZoomScale = scrollView.maximumZoomScale
            let size_w = scrollView.frame.width / newZoomScale
            let size_h = scrollView.frame.height / newZoomScale
            scrollView.zoom(to: CGRect(x: touchPoint.x - size_w / 2, y: touchPoint.y - size_h / 2, width: size_w, height: size_h), animated: true)
        }
    }
    
    private func layoutImageView() {
        guard let currentImage = currentImage else { return }
        
        if scrollView.zoomScale > MinScale {
            scrollView.setZoomScale(MinScale, animated: true)
        }
        
        var imageFrame: CGRect = CGRect.zero
        if currentImage.size.width > scrollView.bounds.width ||
            currentImage.size.height > scrollView.bounds.height {
            let imageRatio = currentImage.size.width / currentImage.size.height
            let screenRatio = scrollView.bounds.width / scrollView.bounds.height
            if imageRatio > screenRatio {
                imageFrame.size = CGSize(width: scrollView.bounds.width,
                                         height: currentImage.size.height / currentImage.size.width * scrollView.bounds.size.width)
                imageFrame.origin.x = 0
                imageFrame.origin.y = (scrollView.bounds.size.height - imageFrame.size.height) / 2.0
            } else {
                imageFrame.size = CGSize(width: currentImage.size.width / currentImage.size.height * scrollView.bounds.height,
                                         height: scrollView.bounds.size.height)
                imageFrame.origin.x = (scrollView.bounds.width - imageFrame.size.width) / 2.0
                imageFrame.origin.y = 0
            }
        } else {
            imageFrame.size = currentImage.size
            imageFrame.origin.x = (scrollView.bounds.width - currentImage.size.width) / 2.0
            imageFrame.origin.y = (scrollView.bounds.height - currentImage.size.height) / 2.0
        }
        
        imageView.frame = imageFrame
    }
}

extension ZoomedPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offSetX = scrollView.bounds.width > scrollView.contentSize.width ? (scrollView.bounds.width - scrollView.contentSize.width) * 0.5 : 0.0
        let offSetY = scrollView.bounds.height > scrollView.contentSize.height ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offSetX,
                                   y: scrollView.contentSize.height * 0.5 + offSetY)
    }
}
