//
//  RSMapView.swift
//  RoadSider
//
//  Created by Niyaz Ahmed Amanullah on 3/17/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class RSMapView : UIView  {
    
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)

    lazy var mapView: GMSMapView = {
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        self.addSubview(mapView)
        return mapView
    }()
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate(mapView.attachToSuperView())
    }
}
