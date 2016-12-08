//
//  CreaterMarker.swift
//  Parking Pal
//
//  Created by Matthew Turk on 12/7/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class CreaterMarker: UIViewController {
    
    
    
    override func loadView() {
        var markers = [GMSMarker]()
        var xCoord: UITextView
        var yCoord: UITextView
        var sendButton: UIButton
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.8716,
                                              longitude:122.2727,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 36.8684, longitude: 122.2636)
//        marker.appearAnimation = kGMSMarkerAnimationPop
//        marker.icon = UIImage(named: "flag_icon")
//        marker.map = mapView
//        markers.append(marker)
//        marker.snippet = "Percent Full: 80%\nPrice: $5/hr"
////
//        let marker2 = GMSMarker()
//        marker2.position = CLLocationCoordinate2D(latitude: 41.885, longitude: -87.622)
//        marker2.appearAnimation = kGMSMarkerAnimationPop
//        marker2.icon = UIImage(named: "flag_icon")
//        marker2.map = mapView
//        markers.append(marker2)
//        marker2.snippet = "Percent Full: 40%\nPrice: $7/hr"
//        
//        let marker3 = GMSMarker()
//        marker3.position = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.621)
//        marker3.appearAnimation = kGMSMarkerAnimationPop
//        marker3.icon = UIImage(named: "flag_icon")
//        marker3.map = mapView
//        markers.append(marker3)
//        marker3.snippet = "Percent Full: 30%\nPrice: $15/hr"
        
        
    }
}
