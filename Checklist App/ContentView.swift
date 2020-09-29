//
//  ContentView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/25/20.
//

import SwiftUI

struct ChecklistItem: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}

struct ContentView: View {
    
    // PROPERTIES
    // ==========

    @State var checklistItems = [
        ChecklistItem(name: "Fold clothes", isChecked: true),
        ChecklistItem(name: "Pack for day"),
        ChecklistItem(name: "Send email to Nikhil"),
        ChecklistItem(name: "Eat lunch"),
        ChecklistItem(name: "Pick up green onions", isChecked: true),     /// add comma to end of array to make it easy to update
    ]

    // USER INTERFACE CONTENT + LAYOUT
    var body: some View {
        NavigationView {
            List {
                ForEach(checklistItems) { checklistItem in
                    HStack {
                        Text(checklistItem.name)
                        Spacer()
                        Text(checklistItem.isChecked ? "✅" : "🔲")
                    }
                    .background(Color.white)        // This makes entire row clickable (def trans rows != clickable)
                    .onTapGesture {
                        // $0 = shorthand for first parameter of checklistItems array
                        // firstIndex(where:) finds checklistItems whose id matches id of tapped item (checklistItem)
                        if let matchingIndex = self.checklistItems.firstIndex(where: { $0.id == checklistItem.id }) {
                            self.checklistItems[matchingIndex].isChecked.toggle()
                        }
                        self.printChecklistContents()
                    }
                }
                .onDelete(perform: deleteListItem)      // enables swipe-to-delete gesture
                .onMove(perform: moveListItem)          // enables move gesture
            }
            .navigationBarItems(trailing: EditButton())     // adds edit button method to trailing side of NavigationBar
            .navigationTitle("Checklist")
            .onAppear() {       // standard view method to execute code when list first appears
                self.printChecklistContents()
            }
        }
    }
    
    // METHODS
    // =======
    
    // To print checklist in debug log
    func printChecklistContents() {
        for item in checklistItems {
            print(item)
        }
    }
    // To remove item in checklist
    // IndexSet = index position of item swiped on
    func deleteListItem(whichElement: IndexSet) {
        checklistItems.remove(atOffsets: whichElement)      // deletes IndexSet
        printChecklistContents()
    }
    // To move item in checklist
    // whichElement = current position + destination = position moved to
    func moveListItem(whichElement: IndexSet, destination: Int) {
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
    }
}
// IndexSet = index position of item swiped on
// whichElement = current position

// PREVIEW
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
