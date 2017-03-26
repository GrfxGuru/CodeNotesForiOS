//
//  applicationUserSettingsViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/21/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit
import CoreData
import Evergreen

class UserSettingsViewController: UIViewController {

    @IBOutlet weak var swConfirmNoteDeletion: UISwitch!
    @IBOutlet weak var swPasteReplace: UISwitch!
    @IBOutlet weak var myWebsite: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let displayDeleteAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
        swConfirmNoteDeletion.isOn = displayDeleteAlert
        let pasteReplace = UserDefaults.standard.bool(forKey: "pasteReplace")
        swPasteReplace.isOn = pasteReplace
        let myWebURL = NSMutableAttributedString(string:"https://peterwitham.com")
        if myWebURL.createLink(text: "https://peterwitham.com",
                               URL: "https://peterwitham.com") {
        myWebsite.attributedText = myWebURL
        }
        
        let myWebsiteTap = UITapGestureRecognizer(target: self, action: #selector(self.tapMyWebsiteURL))
        myWebsite.isUserInteractionEnabled = true
        myWebsite.addGestureRecognizer(myWebsiteTap)
    }
    
    func tapMyWebsiteURL(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string:"https://peterwitham.com") as! URL,
                                        options: [:], completionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSettings" {
            UserDefaults.standard.set(swConfirmNoteDeletion.isOn, forKey: "confirmNoteDeletion")
            UserDefaults.standard.set(swPasteReplace.isOn, forKey: "pasteReplace")
        } else if (segue.identifier == "cancelButton") {
            //self.splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }

    @IBAction func btnResetDatabase(_ sender: UIButton) {
        log("Removing all notes from the database", forLevel: .debug)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteRecord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        let navVC: UINavigationController = self.splitViewController!.viewControllers[0] as! UINavigationController
        let sectionsVC: MasterViewController = navVC.topViewController as! MasterViewController
        sectionsVC.getData()
        sectionsVC.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NSMutableAttributedString {
    
    public func createLink(text:String, URL:String) -> Bool {
        
        let foundText = self.mutableString.range(of: text)
        if foundText.location != NSNotFound {
            self.addAttribute(NSLinkAttributeName, value: URL, range: foundText)
            return true
        }
        return false
    }
}
