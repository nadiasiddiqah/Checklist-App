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
    
    // @ObservedObject connects ChecklistView + ChecklistViewModel()
    // @ObservedObject keeps View up-dated on changes to @Published properties in ViewModel
    // checklistObserver var (array) stores instance of ChecklistViewModel + observes it
    @ObservedObject var checklistObserver = ChecklistViewModel()
    
    // USER INTERFACE CONTENT + LAYOUT
        // items = references properties of ChecklistViewModel
        // Insert checklistObserver.items (bc items = checklistObserver object's prop)
        // Add checklistObserver reference to all methods - printChecklistContents(), deleteListItem(), moveListItem()
    var body: some View {
        NavigationView {
            List {
                ForEach(checklistObserver.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.isChecked ? "✅" : "🔲")
                    }
                    .background(Color.white)        // This makes entire row clickable (def trans rows != clickable)
                    .onTapGesture {
                        // $0 = shorthand for first parameter of items array
                        // firstIndex(where:) finds items whose id matches id of tapped item (checklistItem)
                        if let matchingIndex = self.checklistObserver.items.firstIndex(where: { $0.id == item.id }) {
                            self.checklistObserver.items[matchingIndex].isChecked.toggle()
                        }
                        self.checklistObserver.printChecklistContents()
                    }
                }
                .onDelete(perform: checklistObserver.deleteListItem)      // enables swipe-to-delete gesture
                .onMove(perform: checklistObserver.moveListItem)          // enables move gesture
            }
            .navigationBarItems(trailing: EditButton())     // adds edit button method to trailing side of NavigationBar
            .navigationTitle("Checklist")
            .onAppear() {       // standard view method to execute code when list first appears
                self.checklistObserver.printChecklistContents()
            }
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
