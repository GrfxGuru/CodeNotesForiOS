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
        doDeleteRequest(deleteRequest)
    }
    func removeLanguage(languageID: NSManagedObjectID) {
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [languageID])
        doDeleteRequest(deleteRequest)
    }
    // MARK: Helper Functions
    fileprivate func doDeleteRequest(_ deleteRequest: NSBatchDeleteRequest) {
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
    }
}
