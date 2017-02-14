//
//  SecondViewController.swift
//  sampleproject
//
//  Created by Developer88 on 1/25/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {
    
    
    var scrollView : UIScrollView!
    var imageView : UIImageView!
    

    @IBOutlet var v2: UIView!
    @IBOutlet var v1: UIView!
    @IBOutlet var Back: UIButton!
    @IBOutlet var nxt: UIButton!
    var photo : UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: photo)
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = v1.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        //scrollView.backgroundColor = UIColor.blue
        scrollView.contentOffset = CGPoint(x: 33,y:33)
        scrollView.addSubview(imageView)
        v1.addSubview(scrollView)
        view.addSubview(v1)
        scrollView.delegate = self
        setZoomscale()
        setupGestureRecognizer()
        v2.layer.zPosition = 10

        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        UIView.setAnimationDelay(1.0)
        UIView.setAnimationCurve(.easeOut)
        let rot = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        let translate = CGAffineTransform(translationX: 16, y: 394)
        let scale = CGAffineTransform(scaleX: 4.7, y: 5)
        self.v2.transform = rot.concatenating(scale).concatenating(translate)
        self.v2.backgroundColor = UIColor.red
        
        
        UIView.commitAnimations()
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
        
    }
    func setZoomscale(){
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width/imageViewSize.width
        let heightScale = scrollViewSize.height/imageViewSize.height
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 0.5
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let vertical = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontal = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsetsMake(vertical, horizontal, vertical, horizontal)
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    override func viewWillLayoutSubviews() {
        setZoomscale()
    }
    @IBAction func nextwind(_ sender: UIButton) {
        let vc = FourthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bck(_ sender: UIButton) {
        if let navController = self.navigationController{
        navController.popViewController(animated: true)}
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }


}
