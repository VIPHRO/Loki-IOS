import Foundation

// MARK: - Announcement Model
/// Represents a school announcement or notice
struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let author: String
    let date: Date
    let category: AnnouncementCategory
    let isUrgent: Bool
    
    enum AnnouncementCategory: String, CaseIterable {
        case general = "Allgemein"
        case schoolEvents = "Schulveranstaltungen"
        case sports = "Sport"
        case exams = "Prüfungen"
        case clubs = "AGs"
        
        var icon: String {
            switch self {
            case .general: return "megaphone.fill"
            case .schoolEvents: return "calendar.badge.clock"
            case .sports: return "figure.run"
            case .exams: return "doc.text.fill"
            case .clubs: return "star.fill"
            }
        }
    }
    
    static let mockAnnouncements: [Announcement] = [
        Announcement(title: "Schulfest am 15. Juli",
                     content: "Liebe Schülerinnen und Schüler, am 15. Juli findet unser jährliches Schulfest statt. Wir freuen uns auf ein buntes Programm mit Musik, Tanz und kulinarischen Köstlichkeiten. Anmeldungen für Beiträge bis zum 1. Juli im Sekretariat.",
                     author: "Schulleitung",
                     date: Date().addingTimeInterval(-86400 * 2),
                     category: .schoolEvents,
                     isUrgent: false),
        Announcement(title: "Anmeldefrist für Klausuren verlängert",
                     content: "Die Anmeldefrist für die diesjährigen Abschlussklausuren wurde bis zum 20. Juni verlängert. Bitte nutzt die Gelegenheit und meldet euch rechtzeitig an.",
                     author: "Prüfungsamt",
                     date: Date().addingTimeInterval(-86400 * 5),
                     category: .exams,
                     isUrgent: true),
        Announcement(title: "Erfolgreiche Teilnahme am Mathewettbewerb",
                     content: "Unsere Schule hat beim diesjährigen Landeswettbewerb Mathematik den dritten Platz belegt. Herzlichen Glückwunsch an alle Teilnehmerinnen und Teilnehmer!",
                     author: "Fachbereich Mathematik",
                     date: Date().addingTimeInterval(-86400 * 8),
                     category: .general,
                     isUrgent: false),
        Announcement(title: "Neue AG: Robotik & KI",
                     content: "Ab dem kommenden Schuljahr bieten wir eine neue AG zum Thema Robotik und Künstliche Intelligenz an. Interessierte können sich ab sofort im Sekretariat anmelden. Die AG findet immer dienstags um 14 Uhr statt.",
                     author: "Herr Hoffmann",
                     date: Date().addingTimeInterval(-86400 * 3),
                     category: .clubs,
                     isUrgent: false),
        Announcement(title: "Sporttag verschoben",
                     content: "Aufgrund der Wettervorhersage muss der für Freitag geplante Sporttag auf den 25. Juni verschoben werden. Die Einteilungen bleiben bestehen.",
                     author: "Fachbereich Sport",
                     date: Date().addingTimeInterval(-86400 * 1),
                     category: .sports,
                     isUrgent: true)
    ]
}
