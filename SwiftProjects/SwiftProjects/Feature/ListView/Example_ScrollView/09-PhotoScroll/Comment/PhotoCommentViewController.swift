//
//  PhotoCommentViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/7.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        
        return scrollView
    }()
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var titleLab: UILabel = {
        var titleLab = UILabel()
        titleLab.textAlignment = .center
        titleLab.text = "What name fits me best?"
        return titleLab
    }()
    lazy var nameTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.layer.borderWidth = 1.0
        
        return nameTextField
    }()
    
    public var photoName: String! {
        didSet {
            guard let photoName = photoName else { return }
            
            imageView.image = UIImage(named: photoName)
        }
    }
    public var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLab)
        scrollView.addSubview(nameTextField)
        
        initConstraints()
        addTapGesture()
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + 500)
        
    }
}

extension PhotoCommentViewController {
    private func initConstraints() {
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        titleLab.frame = CGRect(x: 0, y: imageView.frame.maxY + 20, width: view.frame.width, height: 25)
        nameTextField.frame = CGRect(x: 20, y: titleLab.frame.maxY + 20, width: view.frame.width - 20 * 2, height: 30)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openPhotoDetail(sender:)))
        imageView.addGestureRecognizer(imageTap)
    }
    
    @objc private func dismissKeyboard() {
        if nameTextField.isEditing {
            nameTextField.resignFirstResponder()
        }
    }
    
    @objc private func openPhotoDetail(sender: AnyObject) {
        let ctr = ZoomedPhotoViewController()
//        ctr.photoName = photoName
        ctr.currentImage = UIImage(named: photoName)
        navigationController?.pushViewController(ctr, animated: true)
    }
}
