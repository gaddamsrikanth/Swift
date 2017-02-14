//
//  CoreDataViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/13/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import CoreData


class CoreDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    let shareData = ShareData.sharedInstance
    var path: IndexPath = []
    var coreData = CoreDataConnection.sharedInstance
    var data = CoreDataConnection()
        var items: [String] = []
    var fetchedData = [Item]()
    
    @IBOutlet var txt1: UITextField!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt1.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ViewCell4",bundle : nil), forCellReuseIdentifier: "ViewCell4")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            tableView.cellForRow(at: indexPath)?.isSelected = true
            self.disp(i: indexPath)
            print(indexPath[1])
        })
        editAction.backgroundColor = UIColor.blue
        
        return [editAction]
    }
    func disp(i: IndexPath){
        let item = fetchedData[i.row]
        txt1.text = item.title
        path = i
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let item = data.itemsFromCoreData[path.row]
        (item as! Item).title = txt1.text!
        shareData.someString = "ABCD!"
        coreData.editManagedObject(completion: { (success) in
            if(success){
                print("updated")
                self.fetch()
            }
        })
        tableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt1.resignFirstResponder()
        return true
    }
    func fetch(){
        fetchedData = data.itemsFromCoreData as! [Item]
        tableView.reloadData()
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "New Item",
                                      message: "Name of the new item",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save",style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            self.saveToCoreData(nameToSave)
        }
        alert.addTextField()
        alert.addAction(saveAction)
        present(alert, animated: true)
        
    }
    func saveToCoreData(_ title: String){
        
        let item = coreData.createManagedObject(CoreDataConnection.kItem) as! Item
        
        item.title = title
        coreData.saveDatabase { (success) in
            if (success){
                self.tableView.reloadData()
                print("Saved")
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return fetchedData.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"ViewCell4",for: indexPath) as! ViewCell4
            let item = fetchedData[indexPath.row]
            cell.lbl1.text = item.title
            //cell.detailTextLabel?.text = "\(item.progress)"
            return cell
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("here \(indexPath.row)")
        
        let item = fetchedData[indexPath.row]

        coreData.saveDatabase { (success) in
            if (success) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    
    // ViewController.swift
    // [1]
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // [2]
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            
            let item = data.itemsFromCoreData[indexPath.row]
            
            coreData.deleteManagedObject(managedObject: item, completion: { (success) in
                if (success){
                    print("Deleted")
                    tableView.deleteRows(at:[indexPath], with: .automatic)
                    
                }
            })
            
            
        }
        
    }
    
}
