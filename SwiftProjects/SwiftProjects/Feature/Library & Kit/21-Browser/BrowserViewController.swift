//
//  BrowserViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit
import WebKit

class BrowserViewController: MSYBaseViewController {

    private var urlStr: String = "https://www.apple.com"
    lazy var barView: UIView = {
        var barView = UIView()
        barView.backgroundColor = .white
        return barView
    }()
    lazy var closeBtn: UIButton = {
        var closeBtn = UIButton(type: .custom)
        closeBtn.setTitle("close", for: .normal)
        closeBtn.setTitleColor(.black, for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClicked(_:)), for: .touchUpInside)
        
        return closeBtn
    }()
    lazy var urlField: UITextField = {
        var urlField = UITextField()
        urlField.text = urlStr
        urlField.placeholder = "请输入网址"
        return urlField
    }()
    lazy var progressBar: UIProgressView = {
        var progressBar = UIProgressView()
        
        return progressBar
    }()
    lazy var webView: WKWebView = {
        var webView  = WKWebView()
        return webView
    }()
    lazy var backButton: UIBarButtonItem = {
        var backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(back(_:)))

        return backButton
    }()
    lazy var forwardButton: UIBarButtonItem = {
        var forwardButton = UIBarButtonItem(title: "forward", style: .plain, target: self, action: #selector(forward(_:)))
        return forwardButton
    }()
    lazy var reloadButton: UIBarButtonItem = {
        var reloadButton = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(reload(_:)))
        return reloadButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCloseItem()
        configToolbarItems()
        initSubView()
        
        urlField.delegate = self
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.load(urlStr)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            backButton.isEnabled = webView.canGoBack
            forwardButton.isEnabled = webView.canGoForward
        } else if keyPath == "estimatedProgress" {
            progressBar.isHidden = webView.estimatedProgress == 1
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}

extension BrowserViewController {
    private func configToolbarItems() {
        navigationController?.setToolbarHidden(false, animated: true)
        if #available(iOS 15.0, *) {
            let appearance = UIToolbarAppearance()
            appearance.backgroundColor = .white
            navigationController?.toolbar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.toolbar.barStyle = .default
            navigationController?.toolbar.barTintColor =  .white
        }
        navigationController?.toolbar.tintColor = .black
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        setToolbarItems([backButton, fixedSpace, forwardButton, flexibleSpace, reloadButton], animated: true)
    }
    fileprivate func initSubView() {
        barView.addSubview(closeBtn)
        barView.addSubview(urlField)
        view.addSubview(barView)
        view.addSubview(progressBar)
        view.addSubview(webView)
        
        closeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(70)
        }
        urlField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(closeBtn.snp.trailing).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-30)
        }
        let margin_top = UIView.msy_statusHeight
        barView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(margin_top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44.0)
        }
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(barView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    // MARK: - Actions
    @objc private func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func back(_ sender: Any) {
      webView.goBack()
    }
    
    @objc private func forward(_ sender: Any) {
      webView.goForward()
    }
    
    @objc private func reload(_ sender: Any) {
      webView.reload()
    }
}

// MARK: - UITextFieldDelegate
extension BrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        urlField.resignFirstResponder()
        if let str = textField.text {
            if !(str.contains("https://") || str.contains("http://")) {
                urlStr = "https://" + str
            } else {
                urlStr = str
            }
            
            webView.load(urlStr)
        }
        
        return false
    }
}

// MARK: - WKNavigationDelegate
extension BrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        urlField.text = webView.url?.absoluteString
        
        progressBar.setProgress(0.0, animated: false)
    }
}

// MARK: - WKWebView Extension
extension WKWebView {
    func load(_ urlString: String) {
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
