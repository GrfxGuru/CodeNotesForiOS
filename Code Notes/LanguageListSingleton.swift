//
//  LanguageListSingleton.swift
//  Code Notes
//
//  Created by Peter Witham on 1/24/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class LanguageListSingleton: NSObject {
    static let dataContainer = LanguageListSingleton()
    
    var dataArray = [String](arrayLiteral: "Swift", "JavaScript", "C++", "HTML", "CSS", "SASS", "LESS", "Bash")
    
    override init() {
    }
}
