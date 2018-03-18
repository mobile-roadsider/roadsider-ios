//
//  RSHomeTabViewController.swift
//  Roadsider
//
//  Created by Niyaz Ahmed Amanullah on 1/6/18.
//  Copyright © 2018 Roadsider. All rights reserved.
//

import UIKit
import RSUtils

class RSHomeTabViewController : UIViewController {
    
    // Mark: Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        var constraints = [sourceLocationField.alignLeft(toView: self.view, offset: 20),
            sourceLocationField.alignRight(toView: self.view, offset: 20),
            sourceLocationField.alignTop(toView: self.view, offset: 50)]
        constraints.append(contentsOf:mapView.attachToSuperView())
        NSLayoutConstraint.activate(constraints)
    }
    
    lazy var mapView:RSMapView = {
        let mapView = RSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        return mapView
    }()
    
    lazy var sourceLocationField : RSTextField = {
        let textField = RSTextField(placeHolderText:"Enter your location")
        textField.backgroundColor = .lightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(textField, aboveSubview: mapView)
        return textField
    }()

}
