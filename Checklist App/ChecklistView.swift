//
//  ContentView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/25/20.
//

import SwiftUI

struct ChecklistView: View {
    
    // PROPERTIES
    // ==========
    
    // ChecklistView's @ObservedObject prop observes changes in ChecklistViewModel's @Published props
    // mainChecklist var (array) stores/observes instance of ChecklistViewModel
    @ObservedObject var mainChecklist = ChecklistViewModel()
    
    // Hides "Add item" pop-up
    @State var newChecklistItemViewIsVisible = false
    
    // USER INTERFACE CONTENT + LAYOUT
        // items = references properties of ChecklistViewModel
        // Insert mainChecklist.items (bc items = mainChecklist object's prop)
        // Add mainChecklist reference to all methods - printChecklistContents(), deleteListItem(), moveListItem()
    var body: some View {
        NavigationView {
            List {
                ForEach(mainChecklist.items) { index in         // RowView defines instance for each item in mainChecklist
                    RowView(checklistItem: self.$mainChecklist.items[index])       // Use of extension to pass binding to each item to RowView
                }
                .onDelete(perform: mainChecklist.deleteListItem)      // enables swipe-to-delete gesture
                .onMove(perform: mainChecklist.moveListItem)          // enables move gesture
            }
            .navigationBarItems(
                leading: Button(action: {self.newChecklistItemViewIsVisible = true}) {      // adds "add item" button
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add item")
                    }
                },
                trailing: EditButton()      // adds edit button
            )
            .navigationBarTitle("Checklist", displayMode: .inline)
            .onAppear() {       // standard view method to execute code when list first appears
                self.mainChecklist.printChecklistContents()
                self.mainChecklist.saveListItems()
            }
        }
        .sheet(isPresented: $newChecklistItemViewIsVisible) {     // displays isPresented parameter if true
            NewChecklistItemView(newChecklist: self.mainChecklist)      // newChecklist has access to mainChecklist data in ChecklistView 
        }
    }
}

// PREVIEW
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChecklistView()
            ChecklistView()
        }
    }
}

