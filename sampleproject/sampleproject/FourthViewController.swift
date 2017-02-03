//
//  FourthViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/31/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import Foundation

class FourthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var age1: Dictionary<String,[Int]?> = [
        "Low": [],
        "Med": [],
        "High": []
    ]
    var arrDict :NSMutableArray=[]
    
    @IBOutlet var back: UIButton!
    @IBOutlet var fwd: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
    }
    
    func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FourthViewController.editButtonPressed))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"ViewCell1" ,bundle: nil), forCellReuseIdentifier: "ViewCell1")
        
    }

    
    @IBAction func nxt(_ sender: Any) {
        let vc = FifthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func bck(_ sender: Any) {
        if let nav = self.navigationController {
        nav.popViewController(animated: true)
        }
        
    }
    
    @IBAction func AddContent(_ sender: Any) {
    jsonParsingFromFile()
    }
        func jsonParsingFromFile()
        {
            let path: NSString = Bundle.main.path(forResource: "1", ofType: "json")! as NSString
            let data : NSData = try! NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped)
            self.startParsing(data: data)
        }
    
    func startParsing(data: NSData){
        let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        for i in 0  ..< (dict.value(forKey: "person") as! NSArray).count
        {
            arrDict.add((dict.value(forKey: "person") as! NSArray) .object(at: i))
            let age2 = Int(((arrDict[i] as AnyObject).value(forKey: "age") as? String)!)!
            var arr: [Int] = []
            print(age1)
            if(age2>10 && age2<30)
            {
                arr = age1["Low"]!!
                arr.append(age2)
                age1["Low"] = arr
            }
            else if(age2>30 && age2<70)
            {
                arr = age1["Med"]!!
                arr.append(age2)
                age1["Med"] = arr
            }
            else{
                arr = age1["High"]!!
                arr.append(age2)
                age1["High"] = arr
            }

        }

        print(arrDict)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell1") as! ViewCell1
        let strTitle : NSString=(arrDict[indexPath.row] as AnyObject).value(forKey: "name") as! NSString
        let img : NSString=(arrDict[indexPath.row] as AnyObject).value(forKey: "image") as! NSString
        
        let key = Array(age1.keys)[indexPath.section]
        let array1 = age1[key]!!
        
        cell.label1.text=strTitle as String
        cell.label2.text=String(describing: array1[indexPath.row])
        cell.imgvw.image = UIImage(named: img as String)
        return cell as ViewCell1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let key = Array(age1.keys)[section]
        return key
        
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return age1.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let key = Array(age1.keys)[section]
        let array1 = age1[key]
        print("\(array1!) adjakbhkdwakdbkadawh")
        return array1!!.count
        
    }

}
