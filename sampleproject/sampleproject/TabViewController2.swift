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

    var a : CLLocationCoordinate2D!
    var b : CLLocationCoordinate2D!
    let locationmanager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var cord : [CLLocationCoordinate2D] = []
    @IBOutlet var textFeild: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            map.delegate = self
            let point1 = MKPointAnnotation()
            let point2 = MKPointAnnotation()
          
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest
            locationmanager.requestWhenInUseAuthorization()
            locationmanager.requestLocation()
            
            let a = locationmanager.location!.coordinate.latitude
            let b = locationmanager.location!.coordinate.longitude
            let locationOne = CLLocationCoordinate2DMake(a, b)
            point1.coordinate = locationOne
            point1.title = "Mumbai"
            map.addAnnotation(point1)
            
            point2.coordinate = CLLocationCoordinate2DMake(40.063700, -75.646277)
            point2.title = "Surat"
            map.addAnnotation(point2)
            map.centerCoordinate = point2.coordinate

            let mumbai = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
            
            let surat = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
            
            map.setRegion(MKCoordinateRegionMake(point1.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
            directionsRequest.source = MKMapItem(placemark: mumbai)
            directionsRequest.destination = MKMapItem(placemark: surat)
            
            directionsRequest.transportType = MKDirectionsTransportType.automobile
            let directions = MKDirections(request: directionsRequest)
            
            directions.calculate(completionHandler: {
                response, error in
                
                if error == nil {
                    self.myRoute = response!.routes[0] as MKRoute
                    print("Route")
                    self.map.add(self.myRoute.polyline)
                }
                else{
                print("Error")
                }
                
            })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.red
        myLineRenderer.lineWidth = 3
        return myLineRenderer
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
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name!
                self.map.addAnnotation(annotation)
                }
            }
        })
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
