import SwiftUI
import CoreData

struct ItemDetailView: View {
    var item: Item
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editContent = ""
    @State private var editMood = "Neutral"
    
    let moods = ["Happy", "Neutral", "Sad"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if isEditing {
                    TextField("Title", text: $editTitle)
                        .font(.title)
                        .padding(.bottom)
                    
                    Picker("Mood", selection: $editMood) {
                        ForEach(moods, id: \.self) { mood in
                            Text(mood)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextEditor(text: $editContent)
                        .frame(minHeight: 200)
                        .padding(.vertical)
                    
                    Button("Save Changes") {
                        saveChanges()
                    }
                } else {
                    Text(item.title ?? "Untitled")
                        .font(.title)
                        .bold()
                    
                    if let timestamp = item.timestamp {
                        Text(timestamp, formatter: itemFormatter)
                            .foregroundColor(.secondary)
                    }
                    
                    if let mood = item.mood {
                        Text("Mood: \(mood)")
                            .padding(.vertical, 4)
                    }
                    
                    Divider()
                    
                    Text(item.content ?? "")
                        .padding(.top)
                    
                    Button("Edit") {
                        startEditing()
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
    }
    
    private func startEditing() {
        editTitle = item.title ?? ""
        editContent = item.content ?? ""
        editMood = item.mood ?? "Neutral"
        isEditing = true
    }
    
    private func saveChanges() {
        item.title = editTitle
        item.content = editContent
        item.mood = editMood
        
        do {
            try viewContext.save()
            isEditing = false
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
