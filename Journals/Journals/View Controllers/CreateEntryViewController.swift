//
//  CreateEntryViewController.swift
//  Journals
//
//  Created by Gladymir Philippe on 8/5/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    var timestamp = NSDate.now
    var entryController: EntryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var moodSegmentControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleTextField.becomeFirstResponder()
    }
   
    @IBAction func cancel(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let entryTitle = titleTextField.text, !entryTitle.isEmpty,
            let entryDetail = detailTextField.text, !entryDetail.isEmpty else { return }
        
        let moodPriorityIndex = moodSegmentControl.selectedSegmentIndex
        let mood = MoodPriority.allCases[moodPriorityIndex]
        let timestamp = Date()
       // Entry(title: entryTitle, bodyText: entryDetail,timestamp: timestamp, mood: mood)
        let entry = Entry(title: entryTitle, bodyText: entryDetail, timestamp: timestamp, mood: mood, context: CoreDataStack.shared.mainContext)
        entryController?.put(entry: entry, completion: { (_) in
        })
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    
}

