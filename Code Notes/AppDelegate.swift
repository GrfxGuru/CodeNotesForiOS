//
//  AppDelegate.swift
//  Code Notes
//
//  Created by Peter Witham on 1/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var notes: [NoteRecord] = []
    var languages: [LanguageList] = []
    let languageListManagement = DefaultLanguageListData()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = (self.window!.rootViewController as? UISplitViewController)!
        let navigationController = (splitViewController.viewControllers[splitViewController.viewControllers.count-1]
                                    as? UINavigationController)!
        navigationController.topViewController!.navigationItem.leftBarButtonItem
                                        = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        configureUserSettings()
        splitViewController.preferredDisplayMode = .automatic
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.29, green: 0.33, blue: 0.38, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor(red:1, green:0.73, blue:0, alpha:1)
        UINavigationBar.appearance().titleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 0.73, blue: 0, alpha: 1)]
        splitViewController.preferredDisplayMode = .allVisible
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain
        // types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits
        // the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
        // Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough
        // application state information to restore your application to its current state in case it is
        // terminated later. If your application supports background execution, this method is called instead of
        // applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of
//        the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
//        If the application was previously in the background, optionally refresh the user interface.
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            let splitViewController = (self.window!.rootViewController as? UISplitViewController)!
            splitViewController.preferredDisplayMode = .primaryOverlay
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate.
//        See also applicationDidEnterBackground:.
        self.saveContext()
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard (secondaryAsNavController.topViewController as? DetailViewController) != nil else { return false }
        return false
    }

    // Configure user settings for the application if they exist, if they do not (this could be first time running)
//    then set the defaults
    func configureUserSettings() {
        if UserDefaults.standard.bool(forKey: "confirmNoteDeletion") {
            UserDefaults.standard.set(true, forKey: "confirmNoteDeletion")
        }
        if UserDefaults.standard.bool(forKey: "pasteReplace") {
            UserDefaults.standard.set(true, forKey: "pasteReplace")
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection
                 * when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although
                // it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
