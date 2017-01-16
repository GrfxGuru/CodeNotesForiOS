//
//  MasterViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/3/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var notesData = [Note]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notesData = loadData()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        self.tableView.rowHeight = 100
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! ViewNoteViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.detailItem = notesData[indexPath.row]
            }
        } else if segue.identifier == "addNote" {
            notesData.append(createNote(name: "", language: "", note: "", date: Date()))
            let newRow = NSIndexPath(row: tableView.numberOfRows(inSection: 0)-1, section: 0)
            self.tableView.selectRow(at: newRow as IndexPath, animated: true, scrollPosition: .bottom)
            let controller = (segue.destination as! UINavigationController).topViewController as! EditNoteViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            controller.note = notesData[(indexPath?.row)!]
            controller.dataSource = notesData
            controller.title = "Add Note"
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! NoteListTableViewCell
        let note = notesData[indexPath.row]
        cell.noteName.text = note.name
        cell.noteDate.text = dateFormatter.string(from: note.date)
        cell.noteLanguage.text = note.language
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // MARK: - Data Handling
    
    func loadData() -> [Note] {
        var loadedNotes = [Note]()
        loadedNotes.append(createNote(name: "Swift Variable Note", language: "Swift", note: "var something:String", date: Date()))
        loadedNotes.append(createNote(name: "JavaScript Opinion Note", language: "JavaScript", note: "JavaScript is a pain", date: Date()))
        return loadedNotes
    }
    
    func createNote(name: String, language:String, note:String, date:Date) -> Note {
        let newNote = Note()
        newNote.name = name
        newNote.language = language
        newNote.note = note
        newNote.date = date
        return newNote
    }
    
    let dateFormatter: DateFormatter = {
        let _formatter = DateFormatter()
        _formatter.dateStyle = .short
        return _formatter
    }()
}
