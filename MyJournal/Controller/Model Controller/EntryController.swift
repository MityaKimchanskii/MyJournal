//
//  EntryController.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import Foundation

class EntryController {
    
//    Create Entry
    static func createEntry(title: String, body: String, journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.createEntry(journal: journal, entry: newEntry)
    }
    
//    Delete Entry
    static func deleteEntry(entry: Entry, journal: Journal) {
        JournalController.shared.deleteEntry(journal: journal, entry: entry)
        
    }
    
//    Update Entry
    static func updateEntry(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalController.shared.save()
    }
}
