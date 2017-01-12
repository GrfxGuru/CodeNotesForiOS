//
//  AddNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/11/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var fieldNoteName: UITextField!
    @IBOutlet weak var fieldNoteLanguage: UITextField!
    @IBOutlet weak var fieldNote: UITextView!
    
    var dataSource = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func btnAddNote(_ sender: UIBarButtonItem) {
        let newNote = Note()
        newNote.name = fieldNoteName.text!
        newNote.language = fieldNoteLanguage.text!
        newNote.note = fieldNote.text
        newNote.date = Date()
        dataSource.append(newNote)
    }
}
