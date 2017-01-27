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
    
    
    
    @IBOutlet var swtch: UISwitch!
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
        if(animals.count != 0 ){
        if(textField.text != "")
        {
            let a = animals.count
            for _ in (0...a){
            if(animals.contains(textField.text!))
            {
                print(textField.text!)
                
                animals.remove(at: animals.index(of: textField.text!)!)
                tableView.reloadData()
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
    
    
    @IBAction func updt(_ sender: Any) {
        if(textField.text != "")
        {
            if let indexPaths = tableView.indexPathsForSelectedRows  {
                
                let sortedArray = indexPaths.sorted {$0.row < $1.row}
                
                for i in (0...sortedArray.count-1).reversed() {
                    
                    animals[sortedArray[i].row] = textField.text!
                }
                
            }

            tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            tableView.cellForRow(at: indexPath)?.isSelected = true
            self.textField.becomeFirstResponder()
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            self.animals.remove(at: indexPath.item)
            tableView.reloadData()
            
        })
        deleteAction.backgroundColor = UIColor.red
        tableView.reloadData()
        return [editAction, deleteAction]
    }
}
