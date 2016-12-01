//
//  MapsViewController.swift
//  Parking Pal
//
//  Created by Allen Wang on 11/30/16.
//  Copyright © 2016 Allen Wang. All rights reserved.
//
import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 41.887,
                                              longitude:-87.622,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.622)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = mapView
        marker.snippet = "Percent Full: 80%\nPrice: $5/hr"
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 41.885, longitude: -87.622)
        marker2.appearAnimation = kGMSMarkerAnimationPop
        marker2.icon = UIImage(named: "flag_icon")
        marker2.map = mapView
        marker2.snippet = "Percent Full: 40%\nPrice: $7/hr"
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.621)
        marker3.appearAnimation = kGMSMarkerAnimationPop
        marker3.icon = UIImage(named: "flag_icon")
        marker3.map = mapView
        marker3.snippet = "Percent Full: 30%\nPrice: $15/hr"
        
        view = mapView
    }
}
