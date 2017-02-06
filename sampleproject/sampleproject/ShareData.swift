//
//  ShareData.swift
//  sampleproject
//
//  Created by Developer88 on 2/6/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation

final class ShareData {
    static let shared = ShareData() //lazy init, and it only runs once
    var stringValue : String!
    var boolValue   : Bool!
}
