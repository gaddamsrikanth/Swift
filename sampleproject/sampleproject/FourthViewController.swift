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

    var arrDict :NSMutableArray=[]
    @IBOutlet var btn1: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"ViewCell1" ,bundle: nil), forCellReuseIdentifier: "ViewCell1")
        
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
        }

        print(arrDict)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrDict.count)
        return arrDict.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell1") as! ViewCell1
        let strTitle : NSString=(arrDict[indexPath.row] as AnyObject).value(forKey: "name") as! NSString
        let strDescription : NSString=(arrDict[indexPath.row] as AnyObject).value(forKey: "age") as! NSString
        let img : NSString=(arrDict[indexPath.row] as AnyObject).value(forKey: "image") as! NSString
        cell.label1.text=strTitle as String
        cell.label2.text=strDescription as String
        cell.imgvw.image = UIImage(named: img as String)
        return cell as ViewCell1
    }

}
