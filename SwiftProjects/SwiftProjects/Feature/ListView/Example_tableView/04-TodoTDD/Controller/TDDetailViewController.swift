//
//  TDDetailViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit
import MapKit

class TDDetailViewController: MSYBaseViewController {
    
    var item: TDItem?
    
    lazy var locationLab: UILabel = {
        let locationLab = UILabel()
        locationLab.numberOfLines = 2
        locationLab.font = UIFont.systemFont(ofSize: 15.0)
        return locationLab
    }()
    lazy var descriptionLab: UILabel = {
        let descriptionLab = UILabel()
        descriptionLab.numberOfLines = 2
        descriptionLab.font = UIFont.systemFont(ofSize: 12.0)
        return descriptionLab
    }()
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        
        title = item.title
        
        view.addSubview(locationLab)
        view.addSubview(descriptionLab)
        view.addSubview(mapView)
        initConstraints()
        
        if let location = item.location {
            locationLab.text = location.name
            descriptionLab.text = item.itemDescription
            centerMapOnLocation(with: location.coordinate)
        }
    }
}


extension TDDetailViewController {
    private func initConstraints() {
        var top = UIView.msy_safeAreaTop
        top += navigationController?.navigationBar.frame.size.height ?? 0
        let safeBottom = UIView.msy_safeAreaBottom
        locationLab.snp.makeConstraints { make in
            make.top.equalTo(view).offset(top + 5)
            make.leading.equalTo(view).offset(15)
            make.trailing.lessThanOrEqualTo(view).offset(-15)
        }
        descriptionLab.snp.makeConstraints { make in
            make.top.equalTo(locationLab.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(15)
            make.trailing.lessThanOrEqualTo(view).offset(-15)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLab.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(-safeBottom)
        }
    }
    private func centerMapOnLocation(with coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }
        
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
