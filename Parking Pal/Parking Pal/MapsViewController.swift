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
        var markers = [GMSMarker]()
        let camera = GMSCameraPosition.camera(withLatitude: 37.87576,
                                              longitude:-122.25735,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.87576, longitude: -122.25735)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "flag_icon")
        marker.map = mapView
        markers.append(marker)
        marker.snippet = "Percent Full: 80%\nPrice: $5/hr"
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 37.8670, longitude: -122.2550)
        marker2.appearAnimation = kGMSMarkerAnimationPop
        marker2.icon = UIImage(named: "flag_icon")
        marker2.map = mapView
        markers.append(marker2)
        marker2.snippet = "Percent Full: 40%\nPrice: $7/hr"
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 37.8726, longitude: -122.2534)
        marker3.appearAnimation = kGMSMarkerAnimationPop
        marker3.icon = UIImage(named: "flag_icon")
        marker3.map = mapView
        markers.append(marker3)
        marker3.snippet = "Percent Full: 30%\nPrice: $15/hr"
        
        view = mapView
    }
}
