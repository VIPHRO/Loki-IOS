import SwiftUI

// MARK: - GradeItem Model
/// Represents a single grade entry for a course
struct GradeItem: Identifiable {
    let id = UUID()
    let courseName: String
    let grade: Double
    let date: Date
    let type: GradeType
    let note: String?
    
    enum GradeType: String, CaseIterable {
        case exam = "Klausur"
        case oral = "Mündlich"
        case homework = "Hausaufgabe"
        case project = "Projekt"
        case test = "Test"
        
        var icon: String {
            switch self {
            case .exam: return "doc.text.fill"
            case .oral: return "mic.fill"
            case .homework: return "book.fill"
            case .project: return "square.stack.3d.up.fill"
            case .test: return "pencil.and.outline"
            }
        }
    }
    
    static let mockGrades: [GradeItem] = [
        GradeItem(courseName: "Mathematik", grade: 1.3, date: Date().addingTimeInterval(-86400 * 10),
                  type: .exam, note: "Analysis I - Sehr gut"),
        GradeItem(courseName: "Deutsch", grade: 2.0, date: Date().addingTimeInterval(-86400 * 15),
                  type: .exam, note: "Erörterung"),
        GradeItem(courseName: "Englisch", grade: 1.7, date: Date().addingTimeInterval(-86400 * 20),
                  type: .oral, note: "Presentation: Climate Change"),
        GradeItem(courseName: "Physik", grade: 2.3, date: Date().addingTimeInterval(-86400 * 25),
                  type: .test, note: "Elektrizitätslehre"),
        GradeItem(courseName: "Geschichte", grade: 2.0, date: Date().addingTimeInterval(-86400 * 5),
                  type: .project, note: "Referat: Weimarer Republik"),
        GradeItem(courseName: "Informatik", grade: 1.0, date: Date().addingTimeInterval(-86400 * 3),
                  type: .exam, note: "Datenstrukturen & Algorithmen"),
        GradeItem(courseName: "Biologie", grade: 2.7, date: Date().addingTimeInterval(-86400 * 12),
                  type: .exam, note: "Genetik"),
        GradeItem(courseName: "Chemie", grade: 3.0, date: Date().addingTimeInterval(-86400 * 18),
                  type: .test, note: "Organische Chemie"),
        GradeItem(courseName: "Mathematik", grade: 1.0, date: Date().addingTimeInterval(-86400 * 30),
                  type: .homework, note: "Übungsblatt 5"),
        GradeItem(courseName: "Englisch", grade: 2.0, date: Date().addingTimeInterval(-86400 * 8),
                  type: .homework, note: "Essay: Digitalization")
    ]
}

// MARK: - CourseAverage
/// Holds the computed average for a course
struct CourseAverage: Identifiable {
    let id = UUID()
    let courseName: String
    let average: Double
    let gradeCount: Int
    let color: Color
}
