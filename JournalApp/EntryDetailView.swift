import SwiftUI
import CoreData

struct EntryDetailView: View {
    let entry: JournalEntry
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEditing: Bool = false
    @State private var editTitle: String = ""
    @State private var editContent: String = ""
    @State private var editMood: String = Mood.neutral.rawValue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if isEditing {
                    TextField("Title", text: $editTitle)
                        .font(.title)
                        .padding(.bottom)
                    
                    Picker("Mood", selection: $editMood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.bottom)
                    
                    TextEditor(text: $editContent)
                        .frame(minHeight: 200)
                        .border(Color.gray.opacity(0.2))
                } else {
                    Text(entry.title ?? "Untitled")
                        .font(.title)
                        .bold()
                    
                    if let mood = entry.mood {
                        Text("Mood: \(mood)")
                    }
                    
                    Text(entry.timestamp ?? Date(), formatter: itemFormatter)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text(entry.content ?? "")
                        .lineSpacing(5)
                }
            }
            .padding()
        }
        .toolbar {
            Button(isEditing ? "Save" : "Edit") {
                if isEditing {
                    saveChanges()
                } else {
                    startEditing()
                }
                isEditing.toggle()
            }
        }
    }
    
    private func startEditing() {
        editTitle = entry.title ?? ""
        editContent = entry.content ?? ""
        editMood = entry.mood ?? Mood.neutral.rawValue
    }
    
    private func saveChanges() {
        entry.title = editTitle
        entry.content = editContent
        entry.mood = editMood
        
        do {
            try viewContext.save()
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
