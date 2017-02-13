//
//  CoreDataViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/13/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import CoreData


class CoreDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var coreData = CoreDataConnection.sharedInstance
    var itemsFromCoreData: [NSManagedObject] {
        
        get {
            
            var resultArray:Array<NSManagedObject>!
            let managedContext = coreData.persistentContainer.viewContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: CoreDataConnection.kItem)
            
            let sortDescriptor = NSSortDescriptor(key:"title", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                resultArray = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            return resultArray
        }
        
    }
    var items: [String] = []
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ViewCell4",bundle : nil), forCellReuseIdentifier: "ViewCell4")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
        return itemsFromCoreData.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"ViewCell4",for: indexPath) as! ViewCell4
            let item = itemsFromCoreData[indexPath.row] as! Item
            cell.lbl1.text = item.title
            print("sdsfdsfdsf")
            //cell.detailTextLabel?.text = "\(item.progress)"
            return cell
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("here \(indexPath.row)")
        
        let item = itemsFromCoreData[indexPath.row] as! Item
        
        if (item.progress == 0){
            item.progress = 1
        }else{
            item.progress = 0
        }
        
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
            
            let item = itemsFromCoreData[indexPath.row] as! Item
            
            coreData.deleteManagedObject(managedObject: item, completion: { (success) in
                if (success){
                    print("Deleted")
                    tableView.deleteRows(at:[indexPath], with: .automatic)
                    
                }
            })
            
            
        }
        
    }
    
}
