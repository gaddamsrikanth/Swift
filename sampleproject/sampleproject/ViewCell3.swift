//
//  ViewCell3.swift
//  sampleproject
//
//  Created by Developer88 on 2/6/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit


class ViewCell3:  UITableViewCell, UIScrollViewDelegate {
    @IBOutlet var scrlvw: UIScrollView!
    
    @IBOutlet var btn1: UIButton!
    
    @IBOutlet var btn2: UIButton!
    var last: CGFloat!
    var off: CGFloat!
    var buttonAction: ((_ sender: AnyObject) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrlvw.delegate = self
        scrlvw.showsHorizontalScrollIndicator = false;
        scrlvw.showsVerticalScrollIndicator = false;
        last = scrlvw.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.last > scrlvw.contentOffset.x ){
               scrlvw.setContentOffset(CGPoint(x: -50, y: 0), animated: true)
        }else if(self.last < scrlvw.contentOffset.x && scrlvw.isDragging == true){
            scrlvw.setContentOffset(CGPoint(x: 50, y: 0), animated: true)
        }
    }
    
    @IBAction func mid(_ sender: Any) {
        let scrollPoint = CGPoint(x: 0 , y: 0)
        print("Button Tapped1")
        if (scrlvw != nil) {
            scrlvw!.setContentOffset(scrollPoint, animated: true)

        }
      
    }
    
    @IBAction func mid1(_ sender: Any) {
    
        let scrollPoint = CGPoint(x: 0 , y: 0)
        print("Button Tapped2")
        if (scrlvw != nil) {
            UIView.animate(withDuration: 0.5, animations: {
                self.scrlvw!.setContentOffset(scrollPoint, animated: false)
            })
        }
    }
    @IBAction func btn(_ sender: Any) {
        self.buttonAction?(sender as AnyObject)
        print("Tapped")
    }
    
}

    
    
    
    
    

