//
//  Code_NotesTests.swift
//  Code NotesTests
//
//  Created by Peter Witham on 1/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import XCTest
import CoreData
@testable import Code_Notes

class LanguageListTests: XCTestCase {
    let languageList = DefaultLanguageListData()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testCreateLanguages() {
        languageList.createLanguages()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LanguageList")
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try XCTAssert(context.count(for: fetchRequest) > 0, "Default languages created")
        }
    }
    func testClearLanguages() {
        languageList.createLanguages()
        languageList.clearLanguages()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LanguageList")
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try XCTAssert(context.count(for: fetchRequest) == 0, "The list is empty")
        }
    }
    func testRemoveLanguage() {
        languageList.createLanguages()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LanguageList")
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let objectID = 0
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [objectID])
        var contextCountBeforeDelete: Int
        do {
            contextCountBeforeDelete = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        do {
            try AppConfiguration.context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        XCTAssert(context.deletedObjects.count > 0, "Language removed from context")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
