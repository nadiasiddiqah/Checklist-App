//
//  ChecklistItem.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/29/20.
//

import Foundation

struct ChecklistItemModel: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}
