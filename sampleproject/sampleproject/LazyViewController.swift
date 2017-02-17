//
//  LazyViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/17/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class LazyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var TableData:Array< String > = Array < String >()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ViewCell4",bundle: nil), forCellReuseIdentifier: "ViewCell4")
        get_data_from_url("http://127.0.0.1:8085/mongoose/fetch")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell4", for: indexPath) as! ViewCell4
        
        cell.lbl1.text = TableData[indexPath.row]
        
        return cell
    }
    
    
    func get_data_from_url(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            self.extract_json(data!)
        })
        task.resume()
    }
    
    func extract_json(_ data: Data)
    {
    
        
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_list = json as? NSArray else
        {
            return
        }
        
        
        if let countries_list = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let country_obj = countries_list[i] as? NSDictionary
                {
                    if let country_name = country_obj["name"] as? String
                    {
                        if let country_code = country_obj["password"] as? String
                        {
                            TableData.append("Name: " + country_name + "Password: " + country_code)
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   

}
