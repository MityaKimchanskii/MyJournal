//
//  EntryListTableViewController.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var journal: Journal?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jurnalCell", for: indexPath)
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = entry.title
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let journal = journal,
              let destinationVC = segue.destination as? EntryDetailViewController else { return }
        if segue.identifier == "updateJurnalSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entryToSend = journal.entries[indexPath.row]
            destinationVC.entry = entryToSend
            destinationVC.journal = journal
        } else if segue.identifier == "addJurnalSegue" {
            destinationVC.journal = journal
        }
    }
}
