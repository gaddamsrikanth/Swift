//
//  ViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var lbl: UILabel!
    @IBOutlet var OutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func txt(_ sender: Any) {
        lbl.text = textField.text
    }
    @IBAction func change(_ sender: UIButton!) {
        let vc = SecondViewController()
        vc.myString = textField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}
