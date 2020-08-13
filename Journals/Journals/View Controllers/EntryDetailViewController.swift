//
//  EntryDetailViewController.swift
//  Journals
//
//  Created by Gladymir Philippe on 8/8/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    var wasEdited = false
    var entryController: EntryController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var moodController: UISegmentedControl!
    @IBOutlet weak var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = editButtonItem
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    @objc func save() {
//        guard let title = titleTextField.text,
//            !title.isEmpty,
//            let bodyText = entryTextView.text else { return }
//
//        let moodPriorityIndex = moodSegmentControl.selectedSegmentIndex
//        let mood = MoodPriority.allCases[moodPriorityIndex]
//        let timestamp = Date()
//
//        Entry(title: title, bodyText: bodyText, timestamp: timestamp, mood: mood, context: CoreDataStack.shared.mainContext)
//
//        do {
//            try CoreDataStack.shared.mainContext.save()
//            navigationController?.dismiss(animated: true, completion: nil)
//        } catch {
//            NSLog("Error saving managed object context: \(error)")
//        }
//
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if wasEdited {
            guard let title = titleTextField.text, !title.isEmpty,
                let entry = entry else { return}
            entry.title = title
            entry.bodyText = entryTextView.text
            let moodIndex = moodController.selectedSegmentIndex
            entry.mood = MoodPriority.allCases[moodIndex].rawValue

            do {
                try CoreDataStack.shared.mainContext.save()
            } catch {
                NSLog("Error saving managed object context: \(error)")
            }
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing { wasEdited = true}
        titleTextField.isUserInteractionEnabled = editing
        entryTextView.isUserInteractionEnabled = editing
        moodController.isUserInteractionEnabled = editing

    }

    
   private func updateViews() {
    titleTextField.text = entry?.title
    titleTextField.isUserInteractionEnabled = isEditing
    
    entryTextView.text = entry?.bodyText
    entryTextView.isUserInteractionEnabled = isEditing
    
        let mood: MoodPriority
        if let moodPriority = entry?.mood {
            mood = MoodPriority(rawValue: moodPriority)!
        } else {
            mood = .🙂
        }
        moodController.selectedSegmentIndex = MoodPriority.allCases.firstIndex(of: mood) ?? 1
        moodController.isUserInteractionEnabled = isEditing
    }

}
