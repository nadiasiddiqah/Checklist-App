//
//  ChecklistItemModel.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 10/1/20.
//

import Foundation

struct ChecklistItemModel: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}
