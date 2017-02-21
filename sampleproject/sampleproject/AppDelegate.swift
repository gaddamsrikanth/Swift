//
//  AppDelegate.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var splitVC = UISplitViewController()
    var window: UIWindow?
    var navcontroller: UINavigationController?
    var vc: ViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /*var firstVC = MasterViewController()
        var secondVC = DetailViewController()
        
        splitVC.viewControllers = [firstVC, secondVC]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
        return true*/
        window = UIWindow()
        
        // IQKeyboardManager.sharedManager().enable = true
        let rootVC = QRController()
        let nav = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    func disp(vc :UIViewController){
        splitVC.viewControllers.remove(at: 1)
//        let vc1 = Bundle.main.loadNibNamed(v, owner: self, options: nil)
        splitVC.viewControllers.append(vc)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
 
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataConnection.sharedInstance.saveContext()
        }
    

}

