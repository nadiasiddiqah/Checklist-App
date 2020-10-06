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
    @Published var items: [ChecklistItemModel] = []
    
    // Class initializers are methods used to set up new class instances
    // For now, set up init -> to print paths of Documents directory + "Checklist.plist" file
    // Later, init will be used to restore the saved checklist when app starts up
    init() {
        print("Documents directory is: \(documentsDirectory())")
        print("Data file path is: \(dataFilePath())")
        loadListItems()
    }
    
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
        saveListItems()
        printChecklistContents()
    }
    
    // To move item in checklist
    // whichElement = current position + destination = position moved to
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
        saveListItems()
        printChecklistContents()
    }
    
    // To find location (url) of app's Documents directory
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
    }
    
    // To find location (url) that stores checklist items (using documentsDirectory() results)
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }
    
    // To convert contents of items array -> binary data saved onto Checklist.plist
    func saveListItems() {
      let encoder = PropertyListEncoder()
      do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
      } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    // To convert binary data saved onto Checklist.plist -> contents of items array
    func loadListItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([ChecklistItemModel].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
}
