import Foundation

// MARK: - NotificationItem Model
/// Represents a push notification or in-app alert
struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let date: Date
    let category: NotificationCategory
    var isRead: Bool
    
    enum NotificationCategory: String, CaseIterable {
        case grade = "Note"
        case schedule = "Stundenplan"
        case announcement = "Aushang"
        case reminder = "Erinnerung"
        case system = "System"
        
        var icon: String {
            switch self {
            case .grade: return "bookmark.fill"
            case .schedule: return "calendar"
            case .announcement: return "megaphone.fill"
            case .reminder: return "bell.fill"
            case .system: return "gear"
            }
        }
    }
    
    static let mockNotifications: [NotificationItem] = [
        NotificationItem(title: "Neue Note in Mathematik",
                         message: "Dr. Schmidt hat eine neue Note (1,3) für die Klausur 'Analysis I' hinzugefügt.",
                         date: Date().addingTimeInterval(-3600 * 2),
                         category: .grade,
                         isRead: false),
        NotificationItem(title: "Stundenplanänderung",
                         message: "Der Unterricht in Physik am Freitag entfällt. Ersatztermin: Montag, 15:00 Uhr.",
                         date: Date().addingTimeInterval(-3600 * 5),
                         category: .schedule,
                         isRead: false),
        NotificationItem(title: "Neuer Aushang: Schulfest",
                         message: "Die Schulleitung hat einen neuen Aushang zum Schulfest am 15. Juli veröffentlicht.",
                         date: Date().addingTimeInterval(-86400),
                         category: .announcement,
                         isRead: false),
        NotificationItem(title: "Klausurvorbereitung",
                         message: "Morgen findet die Mathe-Klausur statt. Vergiss nicht deine Unterlagen mitzubringen!",
                         date: Date().addingTimeInterval(-86400 * 2),
                         category: .reminder,
                         isRead: true),
        NotificationItem(title: "Systemupdate",
                         message: "Die App wurde erfolgreich aktualisiert. Neue Funktionen stehen bereit.",
                         date: Date().addingTimeInterval(-86400 * 3),
                         category: .system,
                         isRead: true),
        NotificationItem(title: "Neue Note in Englisch",
                         message: "Herr Müller hat eine mündliche Note (1,7) hinzugefügt.",
                         date: Date().addingTimeInterval(-86400 * 4),
                         category: .grade,
                         isRead: true),
        NotificationItem(title: "AG-Robotik: Erster Termin",
                         message: "Die neue Robotik-AG startet am Dienstag um 14 Uhr in Raum 401.",
                         date: Date().addingTimeInterval(-86400 * 5),
                         category: .announcement,
                         isRead: true)
    ]
}
