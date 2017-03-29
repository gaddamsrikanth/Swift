//
//  Controller.swift
//  sampleproject
//
//  Created by Developer88 on 2/21/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer


class Controller: UIViewController {
    
    var moviePlayer : MPMoviePlayerViewController?

    
        override func viewDidLoad() {
                super.viewDidLoad()
            
            let url = NSURL(fileURLWithPath: "/Users/itilak/Library/Developer/CoreSimulator/Devices/7AAB1D1A-0B74-45F7-B788-46B5889AEA8C/data/Media/DCIM/100APPLE/IMG_0009.MP4")
            
            let videoURL = url
            moviePlayer = MPMoviePlayerViewController(contentURL: videoURL as URL! )
            
            if let player = moviePlayer {
                player.view.frame = self.view.bounds
                self.present(moviePlayer!, animated: true, completion: nil)
            }
            else {
                NSLog("no player")
            }
//                let deadlineTime = DispatchTime.now() + .seconds(10)
//                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.generateThumnail(url: videoURL, fromTime: 1)
//            }
    }
    
    func generateThumnail(url : NSURL, fromTime:Float64) -> UIImage {
        let asset :AVAsset = AVAsset(url: url as URL)
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = kCMTimeZero;
        assetImgGenerate.requestedTimeToleranceBefore = kCMTimeZero;
        let time: CMTime = CMTimeMakeWithSeconds(fromTime, 600)
        var img: CGImage!
        do{
          try img = assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        } catch {
            print("abcd")
            UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0.0)
            self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }
        
        
        let frameImg : UIImage = UIImage(cgImage: img)
        UIImageWriteToSavedPhotosAlbum(frameImg,self, nil, nil)
        return frameImg
    }
    
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                }
    
    }
