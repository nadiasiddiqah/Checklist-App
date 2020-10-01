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
                ForEach(mainChecklist.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.isChecked ? "✅" : "🔲")
                    }
                    .background(Color.white)        // This makes entire row clickable (def trans rows != clickable)
                    .onTapGesture {
                        // $0 = shorthand for first parameter of items array
                        // firstIndex(where:) finds items whose id matches id of tapped item (checklistItem)
                        if let matchingIndex = self.mainChecklist.items.firstIndex(where: { $0.id == item.id }) {
                            self.mainChecklist.items[matchingIndex].isChecked.toggle()
                        }
                        self.mainChecklist.printChecklistContents()
                    }
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

