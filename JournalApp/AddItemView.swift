import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var content = ""
    @State private var mood = "Neutral"
    
    let moods = ["Happy", "Neutral", "Sad"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Journal Entry")) {
                    TextField("Title", text: $title)
                    
                    Picker("Mood", selection: $mood) {
                        ForEach(moods, id: \.self) { mood in
                            Text(mood)
                        }
                    }
                    .pickerStyle(.menu)
                    
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
                        saveItem()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveItem() {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.title = title
        newItem.content = content
        newItem.mood = mood
        newItem.id = UUID()
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
