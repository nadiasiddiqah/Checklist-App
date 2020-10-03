//
//  RowView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 10/1/20.
//

import SwiftUI

// RowView (called from ChecklistView) - makes each checklist row responsible for drawing itself
struct RowView: View {
    
    // Est binding connection btwn checklistItem of RowView + EditChecklistItemView
    // Need to specify that RowView doesn't pass (only binds) checklistItem that it receives from ChecklistView
    @Binding var checklistItem: ChecklistItemModel
    
    var body: some View {
        // Set RowView's $checklistItem prop -> indicates two-way binding to ChecklistView's checklistItem prop
        NavigationLink(destination: EditChecklistItemView(editChecklist: $checklistItem)) {
            HStack {
                Text(checklistItem.name)
                Spacer()
                Text(checklistItem.isChecked ? "✅" : "🔲")
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        // Update RowView to include checklistItem var with ChecklistItemModel instance + its initial value
        RowView(checklistItem: .constant(ChecklistItemModel(name: "Sample item")))
    }
}
