import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case neutral = "Neutral"
    case sad = "Sad"
    
    var id: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .happy: return "face.smiling"
        case .neutral: return "face.neutral"
        case .sad: return "cloud.rain"
        }
    }
}
