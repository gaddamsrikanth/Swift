//
//  Controller.swift
//  sampleproject
//
//  Created by Developer88 on 2/21/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation

class Controller: UIViewController,UIGestureRecognizerDelegate {
    
    var moviePlayer : MPMoviePlayerViewController?
    var videoURL : NSURL!
    let playerViewController = AVPlayerViewController()
    var player : AVPlayer!
    var url : NSURL!

        override func viewDidLoad() {
                super.viewDidLoad()
            
             url = NSURL(fileURLWithPath: "/Users/itilak/Library/Developer/CoreSimulator/Devices/028480F2-879E-487C-BDAC-52790BA87828/data/Containers/Data/Application/5FE220C6-4659-4B93-A63E-F333EEB19905/Library/Caches/al/1461134316_570x320_low_quality.mp4")
            
            player = AVPlayer(url: url as URL)
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                self.playerViewController.player!.play()
            }
            
            let singleFingerTap = UITapGestureRecognizer(target: self, action: #selector(self.ss))
            singleFingerTap.delegate = self
            self.playerViewController.view.subviews[0].addGestureRecognizer(singleFingerTap)

    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return true
        
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer touch: UITouch) -> Bool {
        
        return true
    }
    
    func ss(){
       let floatTime = Float(CMTimeGetSeconds(player.currentTime()))
        generateThumnail(url: url
            , fromTime: Float64(floatTime))
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
            _ = UIGraphicsGetImageFromCurrentImageContext()
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
