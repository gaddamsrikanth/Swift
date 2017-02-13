//
//  SeventhViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/9/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class SeventhViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pick = ["1","2","3","4"]
    var pick1 = ["A","B","C","D"]
    
    @IBOutlet var slct: UILabel!
    @IBOutlet var txt1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()

        pickerView.delegate = self
        txt1.inputView = pickerView
        let f1 = txt1.frame.origin
        txt1.frame.origin = CGPoint(x: -20, y: txt1.frame.origin.y)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.txt1.frame.origin = f1
        }, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component==0){
        return pick.count
        }
        else{
        return pick1.count
        }
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component==0){
        return pick[row]
        }
        else
        {
        return pick1[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
            txt1.text = "\(pick[pickerView.selectedRow(inComponent: 0)]) \(pick1[pickerView.selectedRow(inComponent: 1)])"
        
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
