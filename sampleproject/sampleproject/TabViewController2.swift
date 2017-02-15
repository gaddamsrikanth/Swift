//
//  TabViewController2.swift
//  sampleproject
//
//  Created by Developer88 on 1/31/17.
//  Copyright © 2017 None. All rights reserved.
//
import MapKit
import UIKit

class TabViewController2: UIViewController,CLLocationManagerDelegate {
    var a : CLLocationCoordinate2D!
    var b : CLLocationCoordinate2D!
    let locationmanager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    @IBOutlet var textFeild: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest
            locationmanager.requestWhenInUseAuthorization()
            locationmanager.requestLocation()
       let a = locationmanager.location!.coordinate.latitude
    let b = locationmanager.location!.coordinate.longitude
            print(a)
            print(b)
            let locationOne = CLLocationCoordinate2DMake(a, b)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationOne
            map.addAnnotation(annotation as MKAnnotation)
            
            
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
        if let location = locations.first{
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegionMake(location.coordinate, span)
            map.setRegion(region, animated: true)
        }
        
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
                    annotation.title = item.name
                    
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
