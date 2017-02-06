//
//  DetailViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/6/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var contname : Any?
    @IBOutlet var view1: UIView!
    @IBOutlet var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value = ShareData.shared.stringValue {
            print(value)
        }
        label1.text = ShareData.shared.stringValue
        // Do any additional setup after loading the view.
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
