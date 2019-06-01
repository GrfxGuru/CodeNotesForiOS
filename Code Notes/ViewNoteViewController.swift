//
//  ViewNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/9/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import MarkdownKit

class ViewNoteViewController: UIViewController {

    @IBOutlet weak var lblNoteName: UILabel!
    @IBOutlet weak var lblNoteLanguage: UILabel!
    @IBOutlet weak var noteCode: UITextView!
    var detailItem: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        self.view.backgroundColor = Theme.backgroundColor
        noteCode.textColor = Theme.textFieldTextColor
        self.view.backgroundColor = Theme.viewBackgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let controller = ((segue.destination as? UINavigationController)!.topViewController
                as? EditNoteViewController)!
            controller.title = "Edit Note"
            controller.currentNoteIndex = detailItem

        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        let note = (UIApplication.shared.delegate as? AppDelegate)!.notes[detailItem]
        lblNoteName.text = note.noteName
        lblNoteLanguage.text = note.noteLanguage
        let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 18))
        noteCode.attributedText = markdownParser.parse(note.noteContent ?? "Failed to parse Markdown")
        title = note.noteName

        let orientation = UIApplication.shared.statusBarOrientation

        if orientation.isPortrait {
            self.splitViewController?.preferredDisplayMode = .primaryHidden
        }
    }

    @IBAction func btnDeleteNote(_ sender: UIButton) {
        let displayAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
        if displayAlert {
            let alertController = UIAlertController(title: "Delete Note?",
                                                    message: "Are you sure you want to delete this note?",
                                                    preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (_: UIAlertAction!) in
                self.deleteRecord()
                self.navigateAfterDelete()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_: UIAlertAction!) in }
            alertController.addAction(yesAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.deleteRecord()
            self.navigateAfterDelete()
        }
    }
    @IBAction func btnEditNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editNote", sender: self)
    }

    func deleteRecord() {
        let note = (UIApplication.shared.delegate as? AppDelegate)!.notes[detailItem]
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [note.objectID])

        do {
            try AppConfiguration.context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }

    func navigateAfterDelete() {
        let navVC: UINavigationController = (self.splitViewController!.viewControllers[0] as? UINavigationController)!
        let sectionsVC: MasterViewController = (navVC.topViewController as? MasterViewController)!
        sectionsVC.getData()
        sectionsVC.tableView.reloadData()
        self.performSegue(withIdentifier: "unloadView", sender: nil)
    }

    @IBAction func copyToClipboard(_ sender: UIButton) {
        UIPasteboard.general.string = noteCode.text
    }

}
