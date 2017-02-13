//
//  ViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    let section1 = ["pizza", "deep dish pizza", "calzone"]
    var animals : [String] = ["Apple","Apricot","food","D"]
    let cellReuseIdentifier = "cell"
    var refresh : UIRefreshControl!
    var timer: Timer!
    
    @IBOutlet var cr: UIButton!
    @IBOutlet var smpl: UIButton!
    @IBOutlet var swtch: UISwitch!
    @IBOutlet var updt: UIButton!
    @IBOutlet var del: UIButton!
    @IBOutlet var add: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var lbl: UILabel!
    
    @IBOutlet var anm: UIButton!
    
    var selected: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        tableView.addSubview(refresh)
        refresh.backgroundColor = UIColor.red
        refresh.tintColor = UIColor.yellow
        refresh.addTarget(self, action: #selector(ViewController.refresh1(_:)), for: UIControlEvents.valueChanged)
        tableView.register(UINib(nibName:"ViewCell",bundle: nil), forCellReuseIdentifier: "ViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        if(swtch.isOn)
        {
            tableView.allowsMultipleSelection = true
        }
        else
        {
        tableView.allowsMultipleSelection = false}
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as! ViewCell
        let animalName = animals[indexPath.row]
        cell.lbl1!.text = animalName
        cell.imgview!.image = UIImage(named: animalName)
        cell.lbl2!.text = animalName
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    private func textFieldDidEndEditing(_ textView: UITextView){
        print("ABCD")
        self.animals[selected!] = self.textField.text!
        //tableView.reloadData()
    }
    
    @IBAction func anim(_ sender: Any) {
        let vc = Animation()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func smpl(_ sender: Any) {
        let vc = SampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func txt(_ sender: Any) {
        lbl.text = textField.text
    }
    @IBAction func change(_ sender: UIButton!) {
        let vc = ThirdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func added(_ sender: Any) {
        if(textField.text != ""){
        animals.append(textField.text!)
            var s: String!
            do{
            s = try String(contentsOfFile: Bundle.main.path(forResource: "myFile", ofType: "txt")!)
            }catch
            {
                print("Jaadu")
            }
            print(s)
            //tableView.reloadData()
        }}
    
    @IBAction func del(_ sender: Any) {
        if(animals.count != 0 ){
        if(textField.text != "")
        {
            let a = animals.count
            for _ in (0...a){
            if(animals.contains(textField.text!))
            {
                print(textField.text!)
                
                animals.remove(at: animals.index(of: textField.text!)!)
                //tableView.reloadData()
            }
            
            }
        }
        else{
            if let indexPaths = tableView.indexPathsForSelectedRows  {
                
                let sortedArray = indexPaths.sorted {$0.row < $1.row}
                
                for i in (0...sortedArray.count-1).reversed() {
                    
                    animals.remove(at: sortedArray[i].row)
                }
                tableView.deleteRows(at: sortedArray, with: .automatic)
            
            }
        }
    }
        else{
        print("Table does not contain element")
        }
    }
    
    @IBAction func core(_ sender: Any) {
        let vc = CoreDataViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func updt(_ sender: Any) {
        if(textField.text != "")
        {
            if let indexPaths = tableView.indexPathsForSelectedRows  {
                
                let sortedArray = indexPaths.sorted {$0.row < $1.row}
                
                for i in (0...sortedArray.count-1).reversed() {
                    
                    animals[sortedArray[i].row] = textField.text!
                }
                
            }

            //tableView.reloadData()
        }
    }
    
    
    
    @IBAction func swtch(_ sender: Any) {
        if(tableView.allowsMultipleSelection == true)
        {
            tableView.allowsMultipleSelection = false
        }
        else
        {
            tableView.allowsMultipleSelection = true
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func refresh1(_ sender: AnyObject){

       /* timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(ViewController.time2(_:)), userInfo: nil, repeats: true)*/
        time2(self)
    }
    func time2(_ sender: AnyObject){
        tableView.reloadData()
        refresh.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            tableView.cellForRow(at: indexPath)?.isSelected = true
            self.textField.text = self.animals[indexPath.item]
            self.selected = indexPath.item
            print(indexPath[1])
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            self.animals.remove(at: indexPath.item)
            //tableView.reloadData()
            
        })
        deleteAction.backgroundColor = UIColor.red
        //tableView.reloadData()
        return [editAction, deleteAction]
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section1[section]
        
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return section1.count
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return section1.count
        
    }
}
