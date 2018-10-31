//
//  DefaultLanguages.swift
//  Code Notes
//
//  Created by Peter Witham on 8/11/18.
//  Copyright © 2018 Peter Witham. All rights reserved.
//

import Foundation

struct DefaultLanguages {
    // swiftlint:disable comma
    let defaultLanguages = [
        "Java",     "C#",       "C++",      "JavaScript",   "PHP",
        "Python",   "Ruby",     "C",        "Objective-C",  "Scala",
        "CSS",      "Perl",     "Swift",    "HTML",         "SASS",
        "LESS",     "MarkDown", "Bash",     "Go",           "Lua"
    ]
    var getAll: [String] {
        return defaultLanguages
    }
}
