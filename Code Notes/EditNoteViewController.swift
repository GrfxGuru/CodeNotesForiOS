//
//  EditNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/13/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //var note:Note = Note()
    let languagePicker = UIPickerView()
    @IBOutlet weak var fieldNoteName: UITextField!
    @IBOutlet weak var fieldNoteLanguage: UITextField!
    @IBOutlet weak var fieldNoteContent: UITextView!
    let pickerDataSource = LanguageListSingleton.dataContainer.dataArray
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentNoteIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
        fieldNoteName.becomeFirstResponder()
        languagePicker.delegate = self
        fieldNoteLanguage.inputView = languagePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureView() {
        let note = (UIApplication.shared.delegate as! AppDelegate).notes[currentNoteIndex]
        fieldNoteName.text = note.noteName
        fieldNoteLanguage.text = note.noteLanguage
        fieldNoteContent.text = note.noteContent
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC: UINavigationController = self.splitViewController!.viewControllers[0] as! UINavigationController
        let sectionsVC: MasterViewController = navVC.topViewController as! MasterViewController
        if (segue.identifier == "storeNote") {
            let note = NoteRecord(context: context)
            note.dateCreated = Date() as NSDate?
            note.dateModified = Date() as NSDate?
            note.noteLanguage = fieldNoteLanguage.text!
            note.noteName = fieldNoteName.text!
            note.noteContent = fieldNoteContent.text!
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            sectionsVC.tableView.reloadData()
            self.splitViewController?.preferredDisplayMode = .primaryOverlay
        } else {
            let recordCount = (UIApplication.shared.delegate as! AppDelegate).notes.count
            (UIApplication.shared.delegate as! AppDelegate).notes.remove(at: recordCount-1)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            sectionsVC.tableView.reloadData()
            self.splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // TODO: Replace with data count
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // TODO: Replace with proper data
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fieldNoteLanguage.text = pickerDataSource[row]
    }
}
