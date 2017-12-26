//
//  DefaultLanguageListData.swift
//  Code Notes
//
//  Created by Peter Witham on 2/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData

class DefaultLanguageListData: NSObject {
    // swiftlint:disable comma
    let defaultLanguages = [
                            "Java",     "C#",       "C++",      "JavaScript",   "PHP",
                            "Python",   "Ruby",     "C",        "Objective-C",  "Scala",
                            "CSS",      "Perl",     "Swift",    "HTML",         "SASS",
                            "LESS",     "MarkDown", "Bash",     "Go",           "Lua"
                            ]

    func createLanguages() {
        self.clearLanguages()
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        var languageID: Int32 = 1
        for language in defaultLanguages {
            let newLanguage = LanguageList(context: context)
            newLanguage.languageName = language
            newLanguage.languageID = languageID
            (UIApplication.shared.delegate as? AppDelegate)!.languages.append(newLanguage)
            languageID += 1
        }
        (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
    }
    func clearLanguages() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LanguageList")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
    }
    func removeLanguage(languageID: NSManagedObjectID) {
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [languageID])
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
    }
}
