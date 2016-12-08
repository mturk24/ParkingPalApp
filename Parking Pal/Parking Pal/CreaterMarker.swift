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
import MapKit
import CoreLocation

class CreaterMarker: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var delegate = UIApplication.shared.delegate as! AppDelegate //non-optional variable
    


    
    func addBounceAnimationToView(view: UIView)
    {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale") as CAKeyframeAnimation
        bounceAnimation.values = [ 0.05, 1.1, 0.9, 1]
        
        let timingFunctions = NSMutableArray(capacity: bounceAnimation.values!.count)
        
        for i in 0 ..< bounceAnimation.values!.count {
            timingFunctions.add(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions as NSArray as? [CAMediaTimingFunction]
        bounceAnimation.isRemovedOnCompletion = false
        
        view.layer.add(bounceAnimation, forKey: "bounce")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        if (annotation.isKind(of: CustomAnnotation.self)) {
            let customAnnotation = annotation as? CustomAnnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView?.annotation = annotation;
            }
            
            self.addBounceAnimationToView(view: annotationView!)
            return annotationView
        } else {
            return nil
        }
    }
    
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    
    
    @IBAction func callSend(_ sender: AnyObject) {
        
        var myLocation:CLLocationCoordinate2D
        let alert = UIAlertController(title: "Alert", message: "You need to specify a location", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        
        
            
            if (latBox.text!.isEmpty || longBox.text!.isEmpty) {
                self.present(alert, animated: true, completion: nil)
                
            } else {
                myLocation = CLLocationCoordinate2DMake(Double(latBox.text!)!, Double(longBox.text!)!)
                // Drop a pin
                let dropPin = CustomAnnotation(coordinate: myLocation, title: "New Location", subtitle: "Parking Lot", detailURL: NSURL(string: "https://google.com")!, enableInfoButton : true)
                mapView.addAnnotation(dropPin)
                let initialLocation = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
                centerMapOnLocation(location: initialLocation)
               
            }
        
    }
    
    @IBAction func clearFunc(_ sender: AnyObject) {
        for _annotation in self.mapView.annotations {
            if let annotation = _annotation as? MKAnnotation
            {
                self.mapView.removeAnnotation(annotation)
            }
        }
    }
    
    
    
    

    @IBAction func callFunc(_ sender: AnyObject) {
        let myLocation = CLLocationCoordinate2DMake(37.87576, -122.25735)
        // Drop a pin
        let dropPin = CustomAnnotation(coordinate: myLocation, title: "Upper Hearst Parking Structure", subtitle: "Parking Lot", detailURL: NSURL(string: "https://google.com")!, enableInfoButton : true)
        mapView.addAnnotation(dropPin)
        let initialLocation = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
        centerMapOnLocation(location: initialLocation)
    }
//    func showCustomAnnotationWithButton()
//    {
//        
//        
//        
//    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        var currentLocation = CLLocation()
        var currentLong = currentLocation.coordinate.longitude;
        var currentLat = currentLocation.coordinate.latitude;
        print(currentLat, "This is lat")
        print(currentLong, "This long")
        
        self.mapView.setRegion(region, animated: true)
        //        checkLocationAuthorizationStatus()
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var markers = [GMSMarker]()
    @IBOutlet weak var latBox: UITextField!
    @IBOutlet weak var longBox: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var currentLocButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
        }
        
        self.mapView.delegate = self
       
//        let mainLocation = CLLocationCoordinate2DMake(37.8756, -122.2588)
//        // Drop a pin
//        let dropPin = MKPointAnnotation()
//        dropPin.coordinate = mainLocation
//        dropPin.title = "Soda Hall"
//        mapView.addAnnotation(dropPin)
        let position = CLLocation(latitude: 37.87576, longitude: -122.25735)
        centerMapOnLocation(location: position)
        currentLocButton.addTarget(self, action: "callFunc:", for: .touchUpInside)
        sendButton.addTarget(self, action: "callSend:", for: .touchUpInside)
        clearButton.addTarget(self, action: "clearFunc:", for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
//    override func loadView() {

        
//        let camera = GMSCameraPosition.camera(withLatitude: 37.8716,
//                                              longitude:-122.2727,
//                                              zoom:15)
    
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        let mapView = GMSMapView(frame: self.view.bounds)
//        let marker = GMSMarker(position: position)
//        marker.title = "Berkeley"
//        marker.map = mapView
//        mapView.isMyLocationEnabled = true
//        mapView.settings.compassButton = true
//        mapView.settings.myLocationButton = true
//        self.view = mapView
//        
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
        
        
//    }
}
class CustomAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var detailURL: NSURL
    var enableInfoButton : Bool
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, detailURL: NSURL, enableInfoButton : Bool) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.detailURL = detailURL
        self.enableInfoButton = enableInfoButton;
    }
    
    
    
    func annotationView() -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "flag_marker")
        view.rightCalloutAccessoryView = UIButton(type: UIButtonType.custom)
//        view.centerOffset = CGPointMake(0, -32)
        
        if(self.enableInfoButton){
            let deleteButton = UIButton(type: UIButtonType.system) as UIButton
            deleteButton.frame.size.width = 35
            deleteButton.frame.size.height = 35
            deleteButton.backgroundColor = UIColor.white
            deleteButton.setImage(UIImage(named: "info"), for: .normal)
            deleteButton.addTarget(self, action: Selector("infoClicked:"), for: .touchUpInside)
            
            view.leftCalloutAccessoryView = deleteButton
        }
        return view
    }
    
    func infoClicked(sender: AnyObject?) {
        
        print("infoClicked")
        
    }
    
}
