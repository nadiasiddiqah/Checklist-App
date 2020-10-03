//
//  EditChecklistItemView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 10/1/20.
//

import SwiftUI

struct EditChecklistItemView: View {
    
    // editChecklist stores ChecklistItemModel instances
    // allows editChecklist to access its properties (name + isChecked)
    // @Binding allows binding of checklist items to editChecklist (instead of passing copy)
    @Binding var editChecklist: ChecklistItemModel
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $editChecklist.name)
                Toggle("Completed", isOn: $editChecklist.isChecked)
            }
        }
    }
}

struct EditChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditChecklistItemView(editChecklist: .constant(ChecklistItemModel(name: "Sample item")))
    }
}
