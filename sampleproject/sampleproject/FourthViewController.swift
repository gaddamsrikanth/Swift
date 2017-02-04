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
    var ukey: Dictionary<String,[ Int]?> = [
        "Low": [],
        "Med": [],
        "High": []
    ]
    var jsonString: String?
    var jsonData: NSData!
    var arrDict :NSMutableArray=[]
    let path1 = "myFile.txt"
    let path: NSString = Bundle.main.path(forResource: "1", ofType: "json")! as NSString
    
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
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            let key = Array(self.age1.keys)[indexPath.section]
            var array1 = self.age1[key]!!
            array1.remove(at: indexPath.row)
            self.age1[key]!! = array1
            
            _ = Array(self.ukey.keys)[indexPath.section]
            var array2 = self.ukey[key]!!
            var dictkey = array2[indexPath.row]
            for i in 0 ..< self.arrDict.count
            {
                let key1 = ((self.arrDict[i] as AnyObject).value!(forKey: "key") as! Int)
                if(key1 == dictkey){
                 dictkey = i
                    break
                }
        }
            
                self.arrDict.removeObject(at: dictkey)
            print("NewDatar\(self.arrDict)NewData")
            
            tableView.reloadData()
            self.wrt(json: self.arrDict)
            
        })
        deleteAction.backgroundColor = UIColor.red

        return [deleteAction]
    
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
            
            let data : NSData = try! NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped)
            self.startParsing(data: data)
        }
    
    func startParsing(data: NSData){
        let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        for i in 0  ..< (dict.value(forKey: "person") as! NSArray).count
        {
            arrDict.add((dict.value(forKey: "person") as! NSArray) .object(at: i))
            let age2 = Int(((arrDict[i] as AnyObject).value(forKey: "age") as? String)!)!
            let age3 = Int(((arrDict[i] as AnyObject).value(forKey: "key") as? Int)!)
            var arr: [Int] = []
            var arr1: [Int] = []
            print(age1)
            if(age2>10 && age2<30)
            {
                arr = age1["Low"]!!
                arr1 = ukey["Low"]!!
                arr.append(age2)
                arr1.append(age3)
                age1["Low"] = arr
                ukey["Low"] = arr1
            }
            else if(age2>=30 && age2<70)
            {
                arr = age1["Med"]!!
                arr1 = ukey["Med"]!!
                arr.append(age2)
                arr1.append(age3)
                age1["Med"] = arr
                ukey["Med"] = arr1
            }
            else if(age2>70){
                arr = age1["High"]!!
                arr1 = ukey["High"]!!
                arr.append(age2)
                arr1.append(age3)
                age1["High"] = arr
                ukey["High"] = arr1
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
    
        let key = Array(age1.keys)[section]
        let array1 = age1[key]
        print("\(array1!) Rows")
        return array1!!.count
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let key = Array(age1.keys)[sourceIndexPath.section]
        var array1 = age1[key]
        let itemToMove = array1??[sourceIndexPath.row]
        print(itemToMove!)
        array1??.remove(at: sourceIndexPath.row)
        array1??.insert(itemToMove!, at: destinationIndexPath.row)
        age1[key] = array1
        tableView.reloadData()

    }
    
    func wrt(json: AnyObject){
        print("ABCD")
            do {
                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                print(convertedString!) // <-- here is ur string
        let text = "{\n\t\"person\":"+convertedString!+"\n}"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = "/Users/itilak/Desktop/swift/sampleproject/sampleproject/1.json"
            
            do {
                try text.write(toFile: path,  atomically: true, encoding: String.Encoding.utf8)
                print("Successful")
            }
            catch {
            print("Writing not performed")
            }

        }
        else{
        print("Jaadu kei ni jai")
        }
    }
            catch{
        print("Error")
        }
    }
    

}
