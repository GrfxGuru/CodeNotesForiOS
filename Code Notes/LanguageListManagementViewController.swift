//
//  LanguageListManagementViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 2/6/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

class LanguageListManagementViewController: UIViewController {

    @IBOutlet weak var tblLanguages: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    weak var appDelegate = (UIApplication.shared.delegate as? AppDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblLanguages.delegate = self
        tblLanguages.dataSource = self
        tblLanguages.layer.masksToBounds = true
        tblLanguages.layer.borderColor = UIColor( red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0 ).cgColor
        tblLanguages.layer.borderWidth = 1.0
        getData()
        tblLanguages.reloadData()
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        btnAdd.setTitleColor(UIColor.white, for: .normal)
        btnRemove.setTitleColor(UIColor.white, for: .normal)
        btnReset.setTitleColor(UIColor.white, for: .normal)
        btnClear.setTitleColor(UIColor.white, for: .normal)
        btnClose.setTitleColor(UIColor.white, for: .normal)
        btnAdd.backgroundColor = UIColor.lightGray
        btnRemove.backgroundColor = UIColor.lightGray
        btnReset.backgroundColor = UIColor.lightGray
        btnClear.backgroundColor = UIColor.lightGray
        btnClose.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAddLanguage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New Language", message: "Enter Language Name",
                                                preferredStyle: .alert)
        alertController.addTextField(
            configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Language Name"
        })

         let addAction = UIAlertAction(title: "Add",
         style: .default,
         handler: {[weak self] (_: UIAlertAction!) in
         if let textFields = alertController.textFields {
            let theTextFields = textFields as [UITextField]
            let enteredText = theTextFields[0].text
            self?.saveNewLanguage(languageName: enteredText!)
         }
         })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_: UIAlertAction!) in
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func saveNewLanguage(languageName: String) {
        if languageName != "" {
            log("Saving the new language", forLevel: .debug)
            let newLanguage = LanguageList(context: context)
            newLanguage.languageName = languageName
            newLanguage.languageID = 0
            (UIApplication.shared.delegate as? AppDelegate)!.languages.append(newLanguage)
            (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
            getData()
            tblLanguages.reloadData()
        }
    }

    @IBAction func btnRemoveLanguage(_ sender: UIButton) {
        if tblLanguages.indexPathForSelectedRow == nil {
            let alertController = UIAlertController(title: "", message: "Please Select a Language First",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (_: UIAlertAction!) in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            log("Removing selected language", forLevel: .debug)
            let selectedID = tblLanguages.indexPathForSelectedRow
            if let cellNum = selectedID?[1] {
                let language = (UIApplication.shared.delegate as? AppDelegate)!.languages[cellNum]
                (UIApplication.shared.delegate as? AppDelegate)!.languageListManagement.removeLanguage(
                    languageID: language.objectID)

                getData()
                tblLanguages.reloadData()
            }
        }
    }

    @IBAction func btnResetLanguages(_ sender: UIButton) {
        log("Resetting the language list", forLevel: .debug)
        (UIApplication.shared.delegate as? AppDelegate)!.languageListManagement.createLanguages()
        getData()
        tblLanguages.reloadData()
    }

    @IBAction func btnClearAllLanguages(_ sender: UIButton) {
        log("Clearing the language list", forLevel: .debug)
        (UIApplication.shared.delegate as? AppDelegate)!.languageListManagement.clearLanguages()
        getData()
        tblLanguages.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func getData() {
        let fetchRequest: NSFetchRequest<LanguageList> = LanguageList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(LanguageList.languageName), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            (UIApplication.shared.delegate as? AppDelegate)!.languages = try context.fetch(fetchRequest)
        } catch {
            print("Data Fetch Failed")
        }
    }
}

extension LanguageListManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as? AppDelegate)!.languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "languageCellb", for: indexPath)
            as? LanguageListTableViewCell)!
        let language = (UIApplication.shared.delegate as? AppDelegate)!.languages[indexPath.row]
        cell.lblLanguageName.text = language.languageName
        cell.languageID = language.languageID
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

extension LanguageListManagementViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
