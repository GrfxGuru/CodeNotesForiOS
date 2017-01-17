//
//  EditNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/13/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    var note:Note = Note()
    var dataSource: [Note] = []
    var noteDataIndex = 0
    @IBOutlet weak var fieldNoteName: UITextField!
    @IBOutlet weak var fieldNoteLanguage: UITextField!
    @IBOutlet weak var fieldNoteContent: UITextView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
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
        // Update the user interface for the detail item.
        fieldNoteName.text      = note.name
        fieldNoteLanguage.text  = note.language
        fieldNoteContent.text   = note.note
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeNote" {
            // TODO: Store the new data, this should trigger a master list refresh
            appDelegate.myAppData.append(createNote(name: fieldNoteName.text!, language: fieldNoteLanguage.text!, note: fieldNoteContent.text!, date: Date()))
        }
    }
    
    func createNote(name: String, language:String, note:String, date:Date) -> Note {
        print();
        let newNote = Note()
        newNote.name = name
        newNote.language = language
        newNote.note = note
        newNote.date = date
        return newNote
    }
}
