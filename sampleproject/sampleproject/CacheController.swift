//
//  CacheController.swift
//  sampleproject
//
//  Created by Developer88 on 2/20/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class CacheController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var indicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.frame = CGRect(x:0.0, y:0.0, width:40.0,height: 40.0);
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubview(toFront: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        session = URLSession.shared
        task = URLSessionDownloadTask()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ViewCell1",bundle:nil), forCellReuseIdentifier: "ViewCell1")

        refreshTableView()
        
        self.tableData = []
        self.cache = NSCache()
        
    }
    
    func refreshTableView(){
        indicator.startAnimating()
        let url:URL! = URL(string: "https://itunes.apple.com/search?term=gta&entity=software")
        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
                do{
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                    self.tableData = dic.value(forKey : "results") as? [AnyObject]
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tableView.reloadData()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell1", for: indexPath) as! ViewCell1
        let dictionary = self.tableData[(indexPath as NSIndexPath).row] as! [String:AnyObject]
        cell.label1.text = dictionary["trackName"] as? String
        cell.imgvw.image = UIImage(named: "placeholder")
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // 2
            // Use cache
            print("Cached image used, no need to download it")
            cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            // 3
            let artworkUrl = dictionary["artworkUrl100"] as! String
            let url:URL! = URL(string: artworkUrl)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    // 4
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 5
                        // Before we assign the image, check whether the current cell is visible
                        if let updateCell = tableView.cellForRow(at: indexPath) {
                            let img:UIImage! = UIImage(data: data)
                            updateCell.imageView?.image = img
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            })
            indicator.stopAnimating()
            task.resume()
        }
        
        return cell
    }


}


