//
//  DefaultLanguageListData.swift
//  Code Notes
//
//  Created by Peter Witham on 2/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData

final class DefaultLanguageListData: NSObject {
    let defaultLanguages = DefaultLanguages.init().getAll
    func createLanguages() {
        self.clearLanguages()
        var languageID: Int32 = 1
        for language in defaultLanguages {
            let newLanguage = LanguageList(context: AppConfiguration.context)
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
        doDeleteRequest(deleteRequest)
    }
    func removeLanguage(languageID: NSManagedObjectID) {
        print("languageID: \(languageID)")
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [languageID])
        doDeleteRequest(deleteRequest)
    }
    // MARK: Helper Functions
    fileprivate func doDeleteRequest(_ deleteRequest: NSBatchDeleteRequest) {
        do {
            try AppConfiguration.context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
    }
}
