//
//  ContentView.swift
//  Checklist App
//
//  Created by Nadia Siddiqah on 9/25/20.
//

import SwiftUI

struct ContentView: View {

    @State var checklistItems = [
        "Fold clothes",
        "Pack for the weekend",
        "Move boxes to car",
        "Full body workout",
        "Start building Checklist app",     /// add comma to end of array to make it easy to update
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(checklistItems, id: \.self) { item in
                    Text(item)
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
    // Method to print checklist in debug log
    func printChecklistContents() {
        for item in checklistItems {
            print(item)
        }
    }
    // Method to remove item in checklist
    func deleteListItem(whichElement: IndexSet) {       // IndexSet = index position of item swiped on
        checklistItems.remove(atOffsets: whichElement)      // deletes IndexSet
        printChecklistContents()
    }
    // Method to move item in checklist
    func moveListItem(whichElement: IndexSet, destination: Int) {       // whichElement = current position
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)       // destination = position moved to
        printChecklistContents()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
