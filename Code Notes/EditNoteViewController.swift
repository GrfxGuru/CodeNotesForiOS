//
//  EditNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/13/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

class EditNoteViewController: UIViewController {

    //var note:Note = Note()
    let languagePicker = UIPickerView()
    @IBOutlet weak var fieldNoteName: UITextField!
    @IBOutlet weak var fieldNoteLanguage: UITextField!
    @IBOutlet weak var fieldNoteContent: UITextView!
    weak var appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    var pickerDataSource = (UIApplication.shared.delegate as? AppDelegate)!.languages
    var currentNoteIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        fieldNoteName.becomeFirstResponder()
        languagePicker.delegate = self
        fieldNoteLanguage.inputView = languagePicker
        fieldNoteContent.layer.masksToBounds = true
        fieldNoteContent.layer.borderColor = UIColor( red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0 ).cgColor
        fieldNoteContent.layer.borderWidth = 1.0
        fieldNoteName.layer.masksToBounds = true
        fieldNoteName.layer.borderColor = UIColor( red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0 ).cgColor
        fieldNoteName.layer.borderWidth = 1.0
        if pickerDataSource.count == 0 {
            fieldNoteLanguage.isEnabled = false
            fieldNoteLanguage.placeholder = "Please add a language to enable"
        }

        let orientation = UIApplication.shared.statusBarOrientation

        if UIInterfaceOrientationIsPortrait(orientation) {
            self.splitViewController?.preferredDisplayMode = .primaryHidden
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    // }

    func configureView() {
        let note = (UIApplication.shared.delegate as? AppDelegate)!.notes[currentNoteIndex]
        fieldNoteName.text = note.noteName
        fieldNoteLanguage.text = note.noteLanguage
        fieldNoteContent.text = note.noteContent
    }

    @IBAction func btnClearContents(_ sender: UIButton) {
        log("Clearing the contents of the note", forLevel: .debug)
        fieldNoteName.text = ""
        fieldNoteContent.text = ""
    }

    @IBAction func btnPasteClipboard(_ sender: UIButton) {
        if let pasteString = UIPasteboard.general.string {
            log("Appending the clipboard string to the note content", forLevel: .debug)
            let pasteReplace = UserDefaults.standard.bool(forKey: "pasteReplace")
            if pasteReplace {
                fieldNoteContent.text = pasteString
            } else {
                fieldNoteContent.insertText("\n" + pasteString)
            }

        }
    }
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC: UINavigationController = (self.splitViewController!.viewControllers[0] as? UINavigationController)!
        let sectionsVC: MasterViewController = (navVC.topViewController as? MasterViewController)!
        if segue.identifier == "storeNote" {
            log("Storing the note", forLevel: .debug)
            let note = appDelegate?.notes[currentNoteIndex]
            note?.dateCreated = Date()
            note?.dateModified = Date()
            note?.noteLanguage = fieldNoteLanguage.text!
            note?.noteName = fieldNoteName.text!
            note?.noteContent = fieldNoteContent.text!
            (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
            sectionsVC.tableView.reloadData()
        } else if segue.identifier == "openLanguageManagement" {
            log("Storing the note", forLevel: .debug)
            let note = appDelegate?.notes[currentNoteIndex]
            note?.dateCreated = Date()
            note?.dateModified = Date()
            if fieldNoteLanguage.text != nil {
                note?.noteLanguage = fieldNoteLanguage.text!
            }
            note?.noteName = fieldNoteName.text!
            note?.noteContent = fieldNoteContent.text!
            (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
            sectionsVC.tableView.reloadData()
            log("Going to language management screen", forLevel: .debug)
        } else {
            log("Removing the new note", forLevel: .debug)
            let recordCount = (UIApplication.shared.delegate as? AppDelegate)!.notes.count
            (UIApplication.shared.delegate as? AppDelegate)!.notes.remove(at: recordCount-1)
            (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
            sectionsVC.tableView.reloadData()
        }
    }
}

extension EditNoteViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row].languageName
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fieldNoteLanguage.text = pickerDataSource[row].languageName
    }
}

extension EditNoteViewController: UIPickerViewDelegate {

}
