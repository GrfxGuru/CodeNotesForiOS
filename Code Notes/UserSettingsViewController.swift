//
//  applicationUserSettingsViewController.swift
//  Code Notes
//
//  Created by Peter Witham on 1/21/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {

    @IBOutlet weak var swConfirmNoteDeletion: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let displayDeleteAlert = UserDefaults.standard.bool(forKey: "confirmNoteDeletion")
        swConfirmNoteDeletion.isOn = displayDeleteAlert
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSettings" {
            UserDefaults.standard.set(swConfirmNoteDeletion.isOn, forKey: "confirmNoteDeletion")
        }
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