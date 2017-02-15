//
//  CoreDataConnection.swift
//  sampleproject
//
//  Created by Developer88 on 2/13/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import CoreData

class CoreDataConnection: NSObject {
    let shareData = ShareData.sharedInstance
    static let sharedInstance = CoreDataConnection()
    static let kItem = "Item"
    static let kFilename = "Model"
    
    // MARK: - Core Data stack
    var itemsFromCoreData: [NSManagedObject] {
        get {
            
            var resultArray:Array<NSManagedObject>!
            let managedContext = self.persistentContainer.viewContext
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

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataConnection.kFilename)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createManagedObject(_ entityName: String )->NSManagedObject {
        
        let managedContext =
            CoreDataConnection.sharedInstance.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        
        let item = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        return item
        
    }
    
    
    func saveDatabase(completion:(_ result: Bool ) -> Void) {
        
        let managedContext =
            CoreDataConnection.sharedInstance.persistentContainer.viewContext
        
        do {
            try managedContext.save()
            
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
        
    }
    
    func editManagedObject(completion:(_ result: Bool ) -> Void) {
        print(shareData.someString)
        let managedContext =
            CoreDataConnection.sharedInstance.persistentContainer.viewContext
        do{
            try managedContext.save()
             completion(true)
        }catch{
            completion(false)
        }
        
    }

        
    func deleteManagedObject( managedObject: NSManagedObject, completion:(_ result: Bool ) -> Void) {
        
        let managedContext =
            CoreDataConnection.sharedInstance.persistentContainer.viewContext
        
        managedContext.delete(managedObject)
        
        do {
            try managedContext.save()
            
            completion(true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
        
    }

}
