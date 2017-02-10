//
//  CoreDataController.swift
//  sampleproject
//
//  Created by Developer88 on 2/10/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class CoreDataController: UIViewController {
    
    @IBOutlet var sbmt: UIButton!
    @IBOutlet var t3: UITextField!
    @IBOutlet var t2: UITextField!
    @IBOutlet var t1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }
    
    @IBAction func submit(_ sender: Any) {
        let newItem = NS.insertNewObjectForEntityForName("Device", inManagedObjectContext: self.managedObjectContext!) as! LogItem
        
        newItem.name = "Wrote Core Data Tutorial"
        newItem.version = "Wrote and post a tutorial on the basics of Core Data to blog."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
