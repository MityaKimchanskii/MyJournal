//
//  JuornalController.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import Foundation
import CoreText

class JournalController {
    
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
//    Create Journal
    func createJurnal(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        save()
    }
    
//    Delete Journal
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        save()
    }
    
//    Create entry to Journal
    func createEntry(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        save()
    }
    
//    Delete Entry from Juornal
    func deleteEntry(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        save()
    }
    
//    Persistence store
//    URL
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("MyJournal.json")
        return url
    }
    
//    Save to persistence store
    func save() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print("Save error")
            print(error)
            print(error.localizedDescription)
        }
    }
    
//    Load from persistence store
    func load() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print("Load error")
            print(error)
            print(error.localizedDescription)
        }
    }
}
