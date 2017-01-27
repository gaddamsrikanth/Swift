//
//  ViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var animals : [String] = ["A","B","C","D"]
    let cellReuseIdentifier = "cell"
    
    
    
    @IBOutlet var updt: UIButton!
    @IBOutlet var del: UIButton!
    @IBOutlet var add: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var lbl: UILabel!
    @IBOutlet var OutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self,forCellReuseIdentifier : cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = self.animals[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row)")
    }
    
    
    
    @IBAction func txt(_ sender: Any) {
        lbl.text = textField.text
    }
    @IBAction func change(_ sender: UIButton!) {
        let vc = SecondViewController()
        vc.myString = textField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func added(_ sender: Any) {
        if(textField.text != ""){
        animals.append(textField.text!)
            tableView.reloadData()
        }}
    
    @IBAction func del(_ sender: Any) {
        
       
        if(textField.text != "")
        {
            if(animals.contains(textField.text!))
            {
                print(textField.text!)
                
                animals.remove(at: animals.index(of: textField.text!)!)
                tableView.reloadData()
            }
            
        }
        else{
            let p = tableView.indexPathForSelectedRow?.item
            if p != nil {
                animals.remove(at: p!)
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func updt(_ sender: Any) {
        if(textField.text != "")
        {
            let p = tableView.indexPathForSelectedRow?.item
            if p != nil {
            animals[p!] = textField.text!
            }
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}
