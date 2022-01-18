//
//  JournalListViewController.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: -    Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        JournalController.shared.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func addJournalBattonPressed(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        JournalController.shared.createJurnal(title: title)
        listTableView.reloadData()
        titleTextField.text = ""
    }
    
    
    // MARK: - Datasourse TableView function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jurnalListCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let journalForDelete = JournalController.shared.journals[indexPath.row]
        JournalController.shared.deleteJournal(journal: journalForDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJurnalSegue" {
            guard let indexPath = listTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EntryListTableViewController else { return }
            let journalToSend = JournalController.shared.journals[indexPath.row]
            destinationVC.journal = journalToSend
        }
    }
}
