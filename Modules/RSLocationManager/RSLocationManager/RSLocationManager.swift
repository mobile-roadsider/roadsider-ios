//
//  RSLocationManager.swift
//  RSLocationManager
//
//  Created by Niyaz Ahmed Amanullah on 3/17/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import Foundation
import CoreLocation

public class RSLocationManager : NSObject  {
    public static let sharedManager = RSLocationManager()
    private lazy var locationManager : CLLocationManager = {
        let lManager = CLLocationManager()
        lManager.delegate = self 
        return lManager
    }()
    
    override init() {
        super.init()
    }

    public func startUpdatingLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()

    }
}

extension RSLocationManager : CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }

    
}
