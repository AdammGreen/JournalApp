// EntryRow.swift
// Displays a single entry in the list

struct EntryRow: View {
    var entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(entry.wrappedTitle)
                    .font(.headline)
                
                Spacer()
                
                if !entry.wrappedMood.isEmpty {
                    Image(systemName: moodIcon(for: entry.wrappedMood))
                        .foregroundColor(moodColor(for: entry.wrappedMood))
                }
            }
            
            Text(entry.wrappedTimestamp, formatter: itemFormatter)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if !entry.wrappedContent.isEmpty {
                Text(entry.wrappedContent)
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func moodIcon(for mood: String) -> String {
        if let mood = Mood(rawValue: mood) {
            return mood.icon
        }
        return "questionmark"
    }
    
    private func moodColor(for mood: String) -> Color {
        switch mood.lowercased() {
        case "happy", "excited": return .green
        case "calm": return .blue
        case "neutral": return .gray
        case "sad", "anxious": return .indigo
        case "angry": return .red
        default: return .gray
        }
    }
}
