//
//  LanguageListManagementViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 2/6/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData

class LanguageListManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var languageTable: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Theme the app
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.cyan]
        
        languageTable.delegate = self
        languageTable.dataSource = self
        languageTable.layer.masksToBounds = true
        languageTable.layer.borderColor = UIColor( red: 128/255, green: 128/255, blue:128/255, alpha: 1.0 ).cgColor
        languageTable.layer.borderWidth = 1.0
        getData()
        languageTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddLanguage(_ sender: UIButton) {
        // TODO: Add functionality for adding a language
    }

    @IBAction func btnRemoveLanguage(_ sender: UIButton) {
        // TODO: Add functionality for removing a selected language
        if ( languageTable.indexPathForSelectedRow == nil ) {
            let alertController = UIAlertController(title: "", message: "Please Select a Language First", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) {
                (action:UIAlertAction!) in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // TODO: Delete selected language
            let selectedID = languageTable.indexPathForSelectedRow
            if let cellNum = selectedID?[1] {
                let language = (UIApplication.shared.delegate as! AppDelegate).languages[cellNum]
                //let deleteRequest = NSBatchDeleteRequest(objectIDs: [language.objectID])
                (UIApplication.shared.delegate as! AppDelegate).languageListManagement.removeLanguage(languageID: language.objectID)
                
                getData()
                languageTable.reloadData()
            }
        }
    }
    
    @IBAction func btnResetLanguages(_ sender: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).languageListManagement.createLanguages()
        getData()
        languageTable.reloadData()
    }
    
    @IBAction func btnClearAllLanguages(_ sender: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).languageListManagement.clearLanguages()
        getData()
        languageTable.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageListTableViewCell
        let language = (UIApplication.shared.delegate as! AppDelegate).languages[indexPath.row]
        cell.lblLanguageName.text = language.languageName
        cell.languageID = language.languageID
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func getData() {
        do {
            (UIApplication.shared.delegate as! AppDelegate).languages = try context.fetch(LanguageList.fetchRequest())
        } catch {
            print("Data Fetch Failed")
        }
    }

}
