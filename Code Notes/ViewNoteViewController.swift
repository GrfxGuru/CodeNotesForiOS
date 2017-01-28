//
//  ViewNoteViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/9/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class ViewNoteViewController: UIViewController {
    
    @IBOutlet weak var lblNoteName: UILabel!
    @IBOutlet weak var lblNoteLanguage: UILabel!
    @IBOutlet weak var noteCode: UITextView!
    var detailItem: Note?
    var displayedNoteDataIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
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
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "editNote" ) {
                //let controller = (segue.destination as! UINavigationController).topViewController as! EditNoteViewController
                //controller.note = DataStoreSingleton.dataContainer.dataArray[displayedNoteDataIndex]
                //controller.title = "Add Note"
            }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if (detailItem) != nil {
            lblNoteName.text = detailItem?.name
            lblNoteLanguage.text = detailItem?.language
            noteCode.text = detailItem?.note
            title = detailItem?.name
        }
    }
    
    @IBAction func btnDeleteNote(_ sender: UIButton) {
        let displayAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
        if (displayAlert) {
            let alertController = UIAlertController(title: "Delete Note?", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
            let YesAction = UIAlertAction(title: "Yes", style: .default) {
                (action:UIAlertAction!) in
                DataStoreSingleton.dataContainer.dataArray.remove(at: self.displayedNoteDataIndex)
                self.navigateAfterDelete()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                (action:UIAlertAction!) in
            }
            alertController.addAction(YesAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            DataStoreSingleton.dataContainer.dataArray.remove(at: self.displayedNoteDataIndex)
            self.navigateAfterDelete()
        }
    }
    
    func navigateAfterDelete() {
        let navVC: UINavigationController = self.splitViewController!.viewControllers[0] as! UINavigationController
        let sectionsVC: MasterViewController = navVC.topViewController as! MasterViewController
        sectionsVC.tableView.reloadData()
        self.performSegue(withIdentifier: "unloadView", sender: nil)
    }
}
