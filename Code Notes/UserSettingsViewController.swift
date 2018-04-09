//
//  applicationUserSettingsViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/21/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

class UserSettingsViewController: UIViewController {

    @IBOutlet weak var swConfirmNoteDeletion: UISwitch!
    @IBOutlet weak var swPasteReplace: UISwitch!
    @IBOutlet weak var myWebsite: UILabel!
    @IBOutlet weak var lblEvergreenURL: UILabel!
    @IBOutlet weak var swDarkTheme: UISwitch!
    @IBOutlet weak var btnRemoveAllNotes: UIButton!
    @IBOutlet weak var btnManageLanguages: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let displayDeleteAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
        swConfirmNoteDeletion.isOn = displayDeleteAlert
        let pasteReplace = UserDefaults.standard.bool(forKey: "pasteReplace")
        swPasteReplace.isOn = pasteReplace
        let darkTheme = UserDefaults.standard.bool(forKey: "darkTheme")
        swDarkTheme.isOn = darkTheme
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem

        let orientation = UIApplication.shared.statusBarOrientation

        if UIInterfaceOrientationIsPortrait(orientation) {
            self.splitViewController?.preferredDisplayMode = .primaryHidden
        }
        btnRemoveAllNotes.setTitleColor(UIColor.white, for: .normal)
        btnManageLanguages.setTitleColor(UIColor.white, for: .normal)
        btnManageLanguages.backgroundColor = UIColor.lightGray
        btnRemoveAllNotes.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSettings" {
            UserDefaults.standard.set(swConfirmNoteDeletion.isOn, forKey: "confirmNoteDeletion")
            UserDefaults.standard.set(swPasteReplace.isOn, forKey: "pasteReplace")
            UserDefaults.standard.set(swDarkTheme.isOn, forKey: "darkTheme")
        } else if segue.identifier == "cancelButton" {
        }
    }

    @IBAction func btnResetDatabase(_ sender: UIButton) {
        log("Removing all notes from the database", forLevel: .debug)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteRecord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        let navVC: UINavigationController = (self.splitViewController!.viewControllers[0] as? UINavigationController)!
        let sectionsVC: MasterViewController = (navVC.topViewController as? MasterViewController)!
        sectionsVC.getData()
        sectionsVC.tableView.reloadData()
    }

    @IBAction func swDarkTheme(_ sender: UISwitch) {
        if swDarkTheme.isOn {
            Theme.darkTheme()
        } else {
            Theme.defaultTheme()
        }
        splitViewController?.loadView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
