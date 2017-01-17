//
//  DataStoreSingleton.swift
//  Code Notes
//
//  Created by Peter Witham on 1/17/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class DataStoreSingleton: NSObject {
    static let dataContainer = DataStoreSingleton()
    
    var dataArray = [Note]()
    
    override init() {
        print("DataStoreSingleton Initialized")
    }
}
