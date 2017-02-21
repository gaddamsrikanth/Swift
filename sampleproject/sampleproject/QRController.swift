//
//  QRController.swift
//  sampleproject
//
//  Created by Developer88 on 2/21/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import UserNotifications

class QRController: UIViewController {
    
    @IBOutlet var btn1: UIButton!
    var isGrantedNotificationAccess:Bool = false
    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge], completionHandler: {
            (granted,error) in
            self.isGrantedNotificationAccess = granted
        })
        let image = generateQRCode(from: "Jaadu")
        img.image = image
    }
    
    
    
    @IBAction func notification(_ sender: Any) {
        if isGrantedNotificationAccess{
        let content = UNMutableNotificationContent()
            content.title = "10 Second Notification Demo"
            content.subtitle = "From MakeAppPie.com"
            content.body = "Notification after 10 seconds - Your pizza is Ready!!"
            content.categoryIdentifier = "message"
            
            let imageName = "fruits"
            guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
            print(imageURL)
            print("ABCD")
            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
            
            content.attachments = [attachment]
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval : 6.0,
                repeats : false
            )
            
            let request = UNNotificationRequest(
                identifier : "10 second request",
                content : content,
                trigger : trigger
            )
            
            UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
}
