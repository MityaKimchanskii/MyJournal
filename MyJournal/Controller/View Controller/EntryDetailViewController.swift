//
//  EntryDetailViewController.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var journal: Journal?
    var entry: Entry?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateView()
    }
    
    // MARK: - IBActions
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        if let entry = entry {
            EntryController.updateEntry(entry: entry, title: title, body: body)
        } else {
            EntryController.createEntry(title: title, body: body, journal: journal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func updateView() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}
