//
//  Jurnal.swift
//  MyJurnal
//
//  Created by Mitya Kim on 1/17/22.
//

import Foundation

class Journal: Codable {
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.title == rhs.title &&
               rhs.entries == lhs.entries
    }
}
