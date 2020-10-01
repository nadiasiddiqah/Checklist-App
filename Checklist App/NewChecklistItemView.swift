//
//  NewChecklistItemView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/30/20.
//

import SwiftUI

struct NewChecklistItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // Property to store ChecklistViewModel instances
    // newChecklist stores mainChecklist prop passed from ChecklistView to NewChecklistItemView
    var newChecklist: ChecklistViewModel
    
    // Property to store new checklist item
    @State var newItemName = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Add new item")
            // Create Form view using Text + Button
            Form {
                // Allows user to enter new item name + name is binded to @state newItemName
                TextField("Enter new item name here", text: $newItemName)
                Button(action: {
                    addListItem()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add new item")
                    }
                }
                .disabled(newItemName.count == 0)       // disables button if newItemName has no characters
            }
            Text("Swipe down to cancel.")
        }
    }
    // Method to add list item when "Add new item" button is pressed
    func addListItem() {
        var newChecklistItem = ChecklistItemModel(name: self.newItemName)
        self.newChecklist.items.append(newChecklistItem)        // newChecklist = provides access to ChecklistViewModel's items
        self.newChecklist.printChecklistContents()              // ..newChecklistItem is appended into items
        self.presentationMode.wrappedValue.dismiss()            // use presentationMode's wrappedValue's dismiss method
                                                                // ..to dismiss NewChecklistItemView (current view after newChecklistItem is appended)
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        // NewChecklistItemView has a newChecklist parameter
        // newChecklist access its values using an instance of ChecklistViewModel (aka mainChecklist)
        NewChecklistItemView(newChecklist: ChecklistViewModel())
    }
}
