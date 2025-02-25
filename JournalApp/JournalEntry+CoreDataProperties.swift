// JournalEntry+CoreDataProperties.swift
// This file defines properties for the JournalEntry entity

import Foundation
import CoreData

extension JournalEntry {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var mood: String?
    
    // Convenience computed properties
    public var wrappedTitle: String {
        title ?? "Untitled Entry"
    }
    
    public var wrappedContent: String {
        content ?? ""
    }
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    public var wrappedMood: String {
        mood ?? "neutral"
    }
}

// Define Mood options for the app
enum Mood: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case excited = "Excited"
    case calm = "Calm"
    case neutral = "Neutral"
    case sad = "Sad"
    case anxious = "Anxious"
    case angry = "Angry"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .happy: return "face.smiling"
        case .excited: return "star.fill"
        case .calm: return "leaf"
        case .neutral: return "face.neutral"
        case .sad: return "cloud.rain"
        case .anxious: return "exclamationmark.circle"
        case .angry: return "flame"
        }
    }
}
