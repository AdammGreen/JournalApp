import SwiftUI
import CoreData

struct NewEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedMood: String = Mood.neutral.rawValue
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Entry Details")) {
                    TextField("Title", text: $title)
                    
                    Picker("Mood", selection: $selectedMood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveEntry() {
        let newEntry = JournalEntry(context: viewContext)
        newEntry.id = UUID()
        newEntry.title = title
        newEntry.content = content
        newEntry.timestamp = Date()
        newEntry.mood = selectedMood
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving entry: \(error)")
        }
    }
}
