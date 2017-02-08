//
//  TabViewController2.swift
//  sampleproject
//
//  Created by Developer88 on 1/31/17.
//  Copyright © 2017 None. All rights reserved.
//
import MapKit
import UIKit

class TabViewController2: UIViewController {

    @IBOutlet var v1: UIView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            let currentLocation = MKMapItem.forCurrentLocation()
            /*let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(25.0305, 121.5360), addressDictionary: nil)*/
            //let taipei = MKMapItem(placemark: markTaipei)
            //taipei.name = "Taipei Daan Park"
            let array = NSArray(objects: currentLocation)
            let parameter = NSDictionary(object: MKLaunchOptionsDirectionsModeDefault, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
            
            MKMapItem.openMaps(with: array as! [MKMapItem], launchOptions: parameter as? [String : Any])
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }


