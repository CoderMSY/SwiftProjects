//
//  TDAddItemViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit
import CoreLocation

class TDAddItemViewController: MSYBaseViewController {
    
    lazy var geocoder: CLGeocoder = {
        let geocoder = CLGeocoder()
        return geocoder
    }()
    var itemManager: TDItemManager?
    
    lazy var titleTF: UITextField! = {
        var textField = UITextField()
        textField.placeholder = "Title"
        
        return textField
    }()
    lazy var addressTF: UITextField! = {
        var textField = UITextField()
        textField.placeholder = "Address"
        
        return textField
    }()
    lazy var descriptionTF: UITextField! = {
        var textField = UITextField()
        textField.placeholder = "Description"
        
        return textField
    }()
    lazy var datePicker: UIDatePicker! = {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.locale = Locale(identifier: "zh_CN")
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            datePicker.locale = Locale(identifier: "zh-Hans")
        }
        return datePicker
    }()
    lazy var sureBtn: UIButton! = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Sure", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(sureBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCloseItem()
        
        view.addSubview(titleTF)
        view.addSubview(addressTF)
        view.addSubview(descriptionTF)
        view.addSubview(datePicker)
        view.addSubview(sureBtn)
        titleTF.delegate = self
        addressTF.delegate = self
        descriptionTF.delegate = self
        
        initFrame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension TDAddItemViewController {
    private func initFrame() {
        let margin = 80.0
        let tf_w = view.frame.size.width - 2 * margin
        let tf_h = 50.0
        var y = CGFloat(UIApplication.msy_keyWindow?.safeAreaInsets.top ?? 0) + CGFloat(navigationController?.navigationBar.bounds.size.height ?? 0) + 15.0
        titleTF.frame = CGRect(x: margin, y: y, width: tf_w, height: tf_h)
        y = titleTF.frame.maxY + 30.0
        addressTF.frame = CGRect(x: margin, y: y, width: tf_w, height: tf_h)
        y = addressTF.frame.maxY + 30.0
        descriptionTF.frame = CGRect(x: margin, y: y, width: tf_w, height: tf_h)
        y = descriptionTF.frame.maxY + 30.0
        datePicker.frame = CGRect(x: 0, y: y, width: view.frame.size.width, height: datePicker.bounds.size.height)
        y = datePicker.frame.maxY + 20.0
        
        let sureBtn_w = 100.0
        let sureBtn_x = (view.bounds.size.width - sureBtn_w) / 2
        sureBtn.frame = CGRect(x: sureBtn_x, y: y, width: sureBtn_w, height: 40.0)
    }
    
    @objc func sureBtnClicked(_ sender: UIButton) {
        guard let title = titleTF.text else { return }
        
        let descriptionStr = descriptionTF.text
        let date: Date? = datePicker.date
        
        var placeMark: CLPlacemark?
        
        if let locationName = addressTF.text, locationName.count > 0 {
            geocoder.geocodeAddressString(locationName) { [weak self]placeMarks, _ in
                placeMark = placeMarks?.first
                
                let item = TDItem(
                    title: title,
                    itemDescription: descriptionStr,
                    timeStamp: date?.timeIntervalSince1970,
                    location: TDLocation(name: locationName, coordinate: placeMark?.location?.coordinate)
                )
                DispatchQueue.main.async {
                    self?.itemManager?.add(item)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            let item = TDItem(
                title: title,
                itemDescription: descriptionStr,
                timeStamp: date?.timeIntervalSince1970,
                location: nil
            )
            self.itemManager?.add(item)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension TDAddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        
        return false
    }
}
