//
//  ChecklistViewModel.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/29/20.
//

import Foundation

// ObservableObject protocol: when used on an object, it allows another object to observe for changes
// Ex: Protocol binds ChecklistViewModel + ChecklistView (observer) - when data updates in ViewModel, it automatically updates in View
class ChecklistViewModel: ObservableObject {
    
    // PROPERTIES
    // ==========
    
    // @Published = ObservableObject prop / changes to this property notifies any observing objects
    // Any changes to checklistItems (ex toggling, deleting, moving item) will update any Views that are observing this Viewmodel
    @Published var items = [
        ChecklistItemModel(name: "Fold clothes", isChecked: true),
        ChecklistItemModel(name: "Pack for day"),
        ChecklistItemModel(name: "Send email to Nikhil"),
        ChecklistItemModel(name: "Eat lunch"),
        ChecklistItemModel(name: "Pick up green onions", isChecked: true),     
    ]
    
    // METHODS
    // =======
    
    // To print checklist in debug log
    func printChecklistContents() {
        for item in items {
            print(item)
        }
        print("==========")
    }
    
    // To remove item in checklist
    // IndexSet = index position of item swiped on
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)      // deletes IndexSet
        printChecklistContents()
    }
    
    // To move item in checklist
    // whichElement = current position + destination = position moved to
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
    }
    
}
