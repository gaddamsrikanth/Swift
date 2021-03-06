//
//  FifthViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/31/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class FifthViewController: UITabBarController,UITabBarControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create Tab one
            let tabOne = ViewController()
            let tabOneBarItem = UITabBarItem(title: "", image: UIImage(named: "apple"), tag: 0)
            
            
            
            tabOne.tabBarItem = tabOneBarItem
            
            
            // Create Tab two
           let tabTwo = SecondViewController()
            let tabTwoBarItem2 = UITabBarItem(title: "", image: UIImage(named : "fruit"), tag: 1)
            
            tabTwo.tabBarItem = tabTwoBarItem2
            
            //Tab 3
            let tabThree = ThirdViewController()
            tabThree.tabBarItem = UITabBarItem(title:"",image: UIImage(named : "Images"),tag: 3)
            
            //Tab 4
            let tabFour = FourthViewController()
            tabFour.tabBarItem = UITabBarItem(title:"tab 4",image: nil,tag: 4)
            
            //Tab 5
            let tabFive = TabViewController1()
            tabFive.tabBarItem = UITabBarItem(title:"tab5",image: UIImage(named: "appl"),tag:5)
            
            //Tab 6
            
            let tabSix = SixthViewController()
            tabSix.tabBarItem = UITabBarItem(title:"tab6",image:nil,tag:6)
            
            
            let tab7 = SeventhViewController()
            tab7.tabBarItem = UITabBarItem(title:"tab7",image:nil,tag:7)
            
            let tab8 = WebViewController()
            tab8.tabBarItem = UITabBarItem(title: "tab8",image: nil,tag: 8)
            
            let tab9 = AlamJsonController()
            tab9.tabBarItem = UITabBarItem(title: "tab9",image: nil,tag: 9)
            
            let tab10 = TabViewController2()
            tab10.tabBarItem = UITabBarItem(title: "Map",image:nil,tag: 10)
            
            let tab11 = LazyViewController()
            tab11.tabBarItem = UITabBarItem(title: "Lazy",image:nil,tag: 11)
            
            let tab12 = CacheController()
            tab12.tabBarItem = UITabBarItem(title: "Cache",image:nil,tag: 12)
            
            self.viewControllers = [tabOne ,tabTwo, tabThree, tabFour,tabFive,tabSix,tab7,tab8,tab9,tab10,tab11,tab12]
        }
    
    
        
        // UITabBarControllerDelegate method
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//            print("Selected \(viewController.title!)")
    self.navigationController?.isNavigationBarHidden = true;
    }
    

    }





