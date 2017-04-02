//
//  MasterViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController?
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as? UINavigationController)!
                                            .topViewController as? DetailViewController
        }
        self.tableView.rowHeight = 95
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = ((segue.destination as? UINavigationController)!.topViewController
                                    as? ViewNoteViewController)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.detailItem = indexPath.row
            }
        } else if segue.identifier == "addNote" {
            log("Adding a new note", forLevel: .debug)
            let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
            let newNote = NoteRecord(context: context)
            newNote.dateCreated = Date() as NSDate
            newNote.dateModified = Date() as NSDate
            newNote.noteName = ""
            newNote.noteLanguage = ""
            newNote.noteContent = ""
            (UIApplication.shared.delegate as? AppDelegate)!.notes.append(newNote)
            (UIApplication.shared.delegate as? AppDelegate)!.saveContext()
            self.tableView.reloadData()
            let newRow = NSIndexPath(row: tableView.numberOfRows(inSection: 0)-1, section: 0)
            self.tableView.selectRow(at: newRow as IndexPath, animated: true, scrollPosition: .bottom)
            if self.tableView.indexPathForSelectedRow != nil {
                let controller = ((segue.destination as? UINavigationController)!.topViewController
                                    as? EditNoteViewController)!
                controller.title = "Add Note"
                controller.currentNoteIndex = newRow.item
            }
        } else if segue.identifier == "appSettings" {
            log("Navigating to app settings", forLevel: .debug)
            if (self.tableView.indexPathForSelectedRow) != nil {
                self.tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as? AppDelegate)!.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
                    as? NoteListTableViewCell)!
        let note = (UIApplication.shared.delegate as? AppDelegate)!.notes[indexPath.row]
        cell.noteName.text = note.noteName
        cell.noteDate.text = dateFormatter.string(from: note.dateCreated! as Date)
        cell.noteLanguage.text = note.noteLanguage
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let displayAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
            if displayAlert {
                let alertController = UIAlertController(title: "Delete Note?",
                                                        message: "Are you sure you want to delete this note?",
                                                        preferredStyle: .alert)
                let YesAction = UIAlertAction(title: "Yes", style: .default) { (_: UIAlertAction!) in
                    self.deleteRecord(tableIndexToDelete: indexPath.row)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_: UIAlertAction!) in }
                alertController.addAction(YesAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.deleteRecord(tableIndexToDelete: indexPath.row)
            }
        }
    }

    // MARK: - Data Handling

    let dateFormatter: DateFormatter = {
        let _formatter = DateFormatter()
        _formatter.dateStyle = .short
        return _formatter
    }()

    func getData() {
        do {
            (UIApplication.shared.delegate as? AppDelegate)!.notes = try context.fetch(NoteRecord.fetchRequest())
            (UIApplication.shared.delegate as? AppDelegate)!.languages = try context.fetch(LanguageList.fetchRequest())
        } catch {
            print("Data Fetch Failed")
        }
    }

    func deleteRecord(tableIndexToDelete: Int) {
        log("Deleting the record", forLevel: .debug)
        let note = (UIApplication.shared.delegate as? AppDelegate)!.notes[tableIndexToDelete]
        let deleteRequest = NSBatchDeleteRequest(objectIDs: [note.objectID])
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        getData()
        self.tableView.reloadData()
    }
}
