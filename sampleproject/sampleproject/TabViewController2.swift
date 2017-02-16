//
//  TabViewController2.swift
//  sampleproject
//
//  Created by Developer88 on 1/31/17.
//  Copyright © 2017 None. All rights reserved.
//
import MapKit
import UIKit

class TabViewController2: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    var myRoute : MKRoute!
    var directionsRequest = MKDirectionsRequest()
    var annotation = MKPointAnnotation()
    var a : CLLocationCoordinate2D!
    var b : CLLocationCoordinate2D!
    var point2 = MKPointAnnotation()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var cord : [CLLocationCoordinate2D] = []
    var count = 0
    let locationmanager = CLLocationManager()
    var ph : String!
    var loc : String!
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var textFeild: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            map.delegate = self
            
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest
            locationmanager.requestWhenInUseAuthorization()
            locationmanager.requestLocation()
            
        let a = locationmanager.location!.coordinate.latitude
        let b = locationmanager.location!.coordinate.longitude
        let locationOne = CLLocationCoordinate2DMake(a, b)
        
        let point1 = MKPointAnnotation()
        point1.coordinate = locationOne
        point1.title = "Start"
        map.addAnnotation(point1)
        
        point2.coordinate = annotation.coordinate
        point2.title = "End"
        map.addAnnotation(point2)
        map.centerCoordinate = point2.coordinate
        
        let start = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
        
        let end = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
            
        map.setRegion(MKCoordinateRegionMake(point1.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
        directionsRequest.source = MKMapItem(placemark: start)
        directionsRequest.destination = MKMapItem(placemark: end)
        directionsRequest.transportType = MKDirectionsTransportType.automobile
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate(completionHandler: {
            response, error in
            if error == nil {
                if(self.count == 0){
                self.myRoute = response!.routes[0] as MKRoute
                self.map.add(self.myRoute.polyline)
                self.count = self.count+1
            }
                else{
                self.map.remove(self.myRoute.polyline)
                    self.myRoute = response!.routes[0] as MKRoute
                    self.map.add(self.myRoute.polyline)
                }
            }
            else{
                print("Error")
            }
            
        })
            
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = UIImage(named: "location")
        annotationView!.image = pinImage
        annotationView!.isEnabled = true
        annotationView!.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.red
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let t = String(self.myRoute.expectedTravelTime)
        let dist = String(myRoute.distance)
        let ac = UIAlertController(title: "Welcome to \(loc!) \n Distance: \(dist) \n Estimate Time: \(t)", message: ph, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse
        {
            locationmanager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    @IBAction func textEdit(_ sender: Any) {
        _ = (sender as AnyObject).resignFirstResponder()
        map.removeAnnotations(map.annotations)
        self.performSearch()
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .satellite
        default: // or case 2
            map.mapType = .hybrid
        }
    }
    
    func performSearch() {
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = textFeild.text
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    self.matchingItems.append(item as MKMapItem)
                    self.annotation.coordinate = self.matchingItems[0].placemark.coordinate
                    if(item.phoneNumber != nil){
                    self.ph = item.phoneNumber!
                    }
                    else{
                    self.ph = ""
                    }
                    self.loc = item.name
                    self.annotation.title = self.loc!
                    self.viewDidLoad()
                    self.map.addAnnotation(self.annotation)
                    
                }
            }
        })
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
