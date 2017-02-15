//
//  ShareData.swift
//  sampleproject
//
//  Created by Developer88 on 2/14/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation

class ShareData{
    class var sharedInstance :ShareData {
        struct Singleton {
            static let instance = ShareData()
        }
        
        return Singleton.instance
    }

    var someString : String! //Some String
    
    var selectedTheme : AnyObject! //Some Object
    
    var someBoolValue : Bool!
}
