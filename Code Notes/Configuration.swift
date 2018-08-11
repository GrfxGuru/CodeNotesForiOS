//
//  Configuration.swift
//  Code Notes
//
//  Created by Peter Witham on 8/11/18.
//  Copyright © 2018 Peter Witham. All rights reserved.
//

import Foundation
import UIKit

enum AppConfiguration {
    static let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
}

// Configure user settings for the application if they exist,
// if they do not (this could be first time running)
// then set the defaults
func configureUserSettings() {
    if UserDefaults.standard.bool(forKey: "confirmNoteDeletion") {
        UserDefaults.standard.set(true, forKey: "confirmNoteDeletion")
    }
    if UserDefaults.standard.bool(forKey: "pasteReplace") {
        UserDefaults.standard.set(true, forKey: "pasteReplace")
    }
    // Check for first run scenario and install default language list
    if UserDefaults.standard.value(forKey: "firstRun") == nil {
        UserDefaults.standard.set(false, forKey: "firstRun")
        (UIApplication.shared.delegate as? AppDelegate)!.languageListManagement.createLanguages()
    }
    // Check for dark theme
    if UserDefaults.standard.value(forKey: "darkTheme") == nil {
        UserDefaults.standard.set(false, forKey: "darkTheme")
        Theme.defaultTheme()
    } else {
        let currentTheme: Bool = UserDefaults.standard.bool(forKey: "darkTheme")
        currentTheme ? Theme.darkTheme() : Theme.defaultTheme()
    }
}
