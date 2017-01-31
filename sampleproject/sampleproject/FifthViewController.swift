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
            let tabOne = TabViewController1()
            let tabOneBarItem = UITabBarItem(title: "1st Tab", image: nil, tag: 0)
            
            tabOne.tabBarItem = tabOneBarItem
            
            
            // Create Tab two
            let tabTwo = TabViewController2()
            let tabTwoBarItem2 = UITabBarItem(title: "2nd Tab", image: nil, tag: 1)
            tabTwo.tabBarItem = tabTwoBarItem2
            self.viewControllers = [tabOne, tabTwo]
        }
        
        // UITabBarControllerDelegate method
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("Selected \(viewController.title!)")
        }
    }





