//
//  Controller.swift
//  sampleproject
//
//  Created by Developer88 on 2/21/17.
//  Copyright © 2017 None. All rights reserved.
//

import AVKit
import AVFoundation

class Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL! as URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
