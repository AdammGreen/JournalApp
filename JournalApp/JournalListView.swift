// JournalListView.swift
// This will replace the current ContentView

import SwiftUI
import CoreData

struct JournalListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: false)],
        animation: .default)
    private var entries: FetchedResults<JournalEntry>
    
    @State private var selectedEntry: JournalEntry?
    @State private var showingNewEntrySheet = false
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedEntry) {
                ForEach(entries, id: \.id) { entry in
                    NavigationLink(value: entry) {
                        EntryRow(entry: entry)
                    }
                }
                .onDelete(perform: deleteEntries)
            }
            .navigationTitle("My Journal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingNewEntrySheet = true }) {
                        Label("New Entry", systemImage: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showingNewEntrySheet) {
                NewEntryView()
            }
        } detail: {
            if let selectedEntry = selectedEntry {
                EntryDetailView(entry: selectedEntry)
            } else {
                Text("Select an entry or create a new one")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Error deleting entries: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
