//
//  ViewCell2.swift
//  sampleproject
//
//  Created by Developer88 on 2/6/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ViewCell2: UITableViewCell {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var left: UIButton!
    @IBOutlet var right: UIButton!
    
    override func awakeFromNib() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(ViewCell2.swipe(sender:)))
        leftSwipe.direction = .left;
        self.mainView.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(ViewCell2.swipe(sender:)))
        rightSwipe.direction = .right;
        self.mainView.addGestureRecognizer(rightSwipe)
    }
    
    func swipe(sender:AnyObject)
    {
        let swipeGesture:UISwipeGestureRecognizer = sender as! UISwipeGestureRecognizer
        if(swipeGesture.direction == .left)
        {
            var frame:CGRect = self.mainView.frame;
            frame.origin.x = -self.left.frame.width;
            self.mainView.frame = frame;
        }
        else if(swipeGesture.direction == .right)
        {
            var frame:CGRect = self.mainView.frame;
            frame.origin.x = +self.right.frame.width;
            self.mainView.frame = frame;
        }
        
    }
    
}
