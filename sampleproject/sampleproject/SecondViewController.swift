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
    
    @IBOutlet var v1: UIView!
    @IBOutlet var Back: UIButton!
    @IBOutlet var nxt: UIButton!
    var photo : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "ss"))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = v1.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        scrollView.backgroundColor = UIColor.blue
        scrollView.contentOffset = CGPoint(x: 33,y:33)
        scrollView.addSubview(imageView)
        v1.addSubview(scrollView)
        view.addSubview(v1)
        scrollView.delegate = self
        setZoomscale()
        setupGestureRecognizer()
        // Do any additional setup after loading the view.
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
        let vc = ThirdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func bck(_ sender: UIButton) {
        if let navController = self.navigationController{
        navController.popViewController(animated: true)}
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
