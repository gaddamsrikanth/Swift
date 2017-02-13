//
//  MasterViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/6/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let controller = [SecondViewController(), ThirdViewController(), FourthViewController(),DetailViewController(),TabViewController2(),TabViewController1()]
    
    @IBOutlet var sbmt: UIButton!
    @IBOutlet var lat: UILabel!
    @IBOutlet var long: UILabel!
    @IBOutlet var t1: UITextField!
    @IBOutlet var t2: UITextField!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var share: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"ViewCell4",bundle: nil), forCellReuseIdentifier: "ViewCell4")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sbmt(_ sender: Any) {
        _ = t1.text
        _ = t2.text
        
    }
    
    @IBAction func shr(_ sender: Any) {
        let url = NSURL.fileURL(withPath: "/Users/itilak/Desktop/swift/sampleproject/sampleproject/1.txt")
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
         activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController,animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell4", for: indexPath) as! ViewCell4
        cell.lbl1.text = controller[indexPath.row].nibName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("You tapped cell number \(indexPath.row)")
        let app = UIApplication.shared.delegate as! AppDelegate
        app.disp(vc: controller[indexPath.row])
        
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
