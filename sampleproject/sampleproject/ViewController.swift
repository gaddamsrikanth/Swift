//
//  ViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var OutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func change(_ sender: UIButton!) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}
