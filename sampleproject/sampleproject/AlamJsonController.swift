//
//  AlamJsonController.swift
//  sampleproject
//
//  Created by Developer88 on 2/15/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class AlamJsonController: UIViewController {
    var arrRes = [[String:AnyObject]]()
    @IBOutlet var tableView: UITableView!
        override func viewDidLoad() {
//            super.viewDidLoad()
//            tableView.dataSource = self
//            tableView.delegate = self
//            tableView.register(UINib(nibName: "ViewCell4",bundle : nil), forCellReuseIdentifier: "ViewCell4")
//            //URLRequest(url: "http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
//                if((responseData.result.value) != nil) {
//                    let swiftyJsonVar = JSON(responseData.result.value!)
//                    
//                    if let resData = swiftyJsonVar["contacts"].arrayObject {
//                        self.arrRes = resData as! [[String:AnyObject]]
//                    }
//                    if self.arrRes.count > 0 {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
        }
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier:"ViewCell4",for: indexPath) as! ViewCell4
//            var dict = arrRes[(indexPath as NSIndexPath).row]
//            cell.lbl1.text = dict["name"] as? String
//
//            return cell
//        }
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            print(arrRes.count)
//            return arrRes.count
//            
//        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
