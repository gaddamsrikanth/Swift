//
//  WebViewController.swift
//  sampleproject
//
//  Created by Developer88 on 2/14/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate, UITextFieldDelegate {
    @IBOutlet var tf: UITextField!
    var wv : UIWebView!
    var url : URL!
    @IBOutlet var hm: UIBarButtonItem!
    @IBOutlet var fwd: UIButton!
    @IBOutlet var back: UIButton!
    @IBOutlet var nav: UINavigationBar!
    var urlreq : URLRequest!
    var go : UIButton!
    @IBOutlet var rfrsh: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        wv = UIWebView(frame: CGRect(x: 0,y : 100,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-120))
        back.addTarget(self, action: #selector(goback), for: UIControlEvents.touchDown)
        fwd.addTarget(self, action: #selector(gofwd), for: UIControlEvents.touchDown)
        self.view.addSubview(wv)
        wv.delegate = self
        tf.delegate = self
        tf.autocorrectionType = .no
        url = URL(string: "www.google.com")
        urlreq = URLRequest(url : url!)
        wv.loadRequest(urlreq)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gofwd(){
        
        if(wv.canGoForward){
            print("Back")
            wv.goForward()
        }
        else if(!wv.canGoForward){
            print("Not")
            let alert = UIAlertController(title: "ALERT!!!!",
                                          message: "End of Internet",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            alert.addAction(cancelAction)
            present(alert,animated: true)
        }
    }
    
    func goback(){
   
        if(wv.canGoBack){
               print("Back")
        wv.goBack()
       }
        else if(!wv.canGoBack){
            print("Not")
            let alert = UIAlertController(title: "ALERT!!!!",
                                          message: "End of Internet",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            alert.addAction(cancelAction)
            present(alert,animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tf.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = tf.text
        let reg = "^.[a-zA-Z]$"
            if (!NSPredicate(format: "SELF MATCHES %@", reg).evaluate(with: str)){
            if tf.text?.range(of:"https://") != nil{
            url = URL(string: tf.text!)
            urlreq = URLRequest(url : url!)
            wv.loadRequest(urlreq)
            print(tf.text!)
            }
            else{
                let ht = "http://www."
                let u = ht.appending(tf.text!)
                url = URL(string: u)
                urlreq = URLRequest(url : url!)
                wv.loadRequest(urlreq)
                print(u)
            }
            }
        else{
            let link = tf.text
            let lm = "https://www.google.co.in/search?q="
            let u = lm.appending(link!)
            url = URL(string: u)
            urlreq = URLRequest(url : url!)
            wv.loadRequest(urlreq)
            print(u)
        }
    
    }
    
        func verifyUrl (urlString: String?) -> Bool {
            if let urlString = urlString {
                if let url  = NSURL(string: urlString) {
                    return UIApplication.shared.canOpenURL(url as URL)
                }
            }
            return false
        }
        
    func webViewDidStartLoad(_ webView: UIWebView) {
    
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let currentURL : NSString = (wv.request?.url!
            .absoluteString)! as NSString
        tf.text = currentURL as String
    }
    

    @IBAction func refresh(_ sender: Any) {
        wv.reload()
    }
    
    @IBAction func cncl(_ sender: Any) {
    wv.stopLoading()
    }
    
}
