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
    
    func configureView() {
        // Update the user interface for the detail item.
        if (detailItem) != nil {
            lblNoteName.text = detailItem?.name
            lblNoteLanguage.text = detailItem?.language
            noteCode.text = detailItem?.note
        }
    }

}
