import SwiftUI

// MARK: - ScheduleItem Model
/// Represents a single schedule entry with course details
struct ScheduleItem: Identifiable {
    let id = UUID()
    let courseName: String
    let teacher: String
    let room: String
    let startTime: String
    let endTime: String
    let dayOfWeek: Int // 1 = Monday, 7 = Sunday
    let color: Color
    
    static let mockSchedule: [ScheduleItem] = [
        ScheduleItem(courseName: "Mathematik", teacher: "Dr. Schmidt", room: "R. 101",
                     startTime: "08:00", endTime: "09:30", dayOfWeek: 1, color: .cardSchedule),
        ScheduleItem(courseName: "Deutsch", teacher: "Frau Weber", room: "R. 203",
                     startTime: "09:45", endTime: "11:15", dayOfWeek: 1, color: .appSecondary),
        ScheduleItem(courseName: "Englisch", teacher: "Herr Müller", room: "R. 105",
                     startTime: "11:30", endTime: "13:00", dayOfWeek: 1, color: .appSuccess),
        ScheduleItem(courseName: "Physik", teacher: "Dr. Schneider", room: "R. 301",
                     startTime: "08:00", endTime: "09:30", dayOfWeek: 2, color: .appWarning),
        ScheduleItem(courseName: "Geschichte", teacher: "Frau Becker", room: "R. 204",
                     startTime: "09:45", endTime: "11:15", dayOfWeek: 2, color: .cardNotifications),
        ScheduleItem(courseName: "Informatik", teacher: "Herr Hoffmann", room: "R. 401",
                     startTime: "11:30", endTime: "13:00", dayOfWeek: 2, color: .appPrimary),
        ScheduleItem(courseName: "Biologie", teacher: "Frau Klein", room: "R. 302",
                     startTime: "08:00", endTime: "09:30", dayOfWeek: 3, color: .appSuccess),
        ScheduleItem(courseName: "Chemie", teacher: "Dr. Wolf", room: "R. 303",
                     startTime: "09:45", endTime: "11:15", dayOfWeek: 3, color: .appWarning),
        ScheduleItem(courseName: "Sport", teacher: "Herr Fuchs", room: "Sporthalle",
                     startTime: "11:30", endTime: "13:00", dayOfWeek: 3, color: .cardAnnouncements),
        ScheduleItem(courseName: "Englisch", teacher: "Herr Müller", room: "R. 105",
                     startTime: "08:00", endTime: "09:30", dayOfWeek: 4, color: .appSuccess),
        ScheduleItem(courseName: "Mathematik", teacher: "Dr. Schmidt", room: "R. 101",
                     startTime: "09:45", endTime: "11:15", dayOfWeek: 4, color: .cardSchedule),
        ScheduleItem(courseName: "Kunst", teacher: "Frau Richter", room: "R. 205",
                     startTime: "11:30", endTime: "13:00", dayOfWeek: 4, color: .appSecondary),
        ScheduleItem(courseName: "Deutsch", teacher: "Frau Weber", room: "R. 203",
                     startTime: "08:00", endTime: "09:30", dayOfWeek: 5, color: .appSecondary),
        ScheduleItem(courseName: "Geschichte", teacher: "Frau Becker", room: "R. 204",
                     startTime: "09:45", endTime: "11:15", dayOfWeek: 5, color: .cardNotifications),
        ScheduleItem(courseName: "Physik", teacher: "Dr. Schneider", room: "R. 301",
                     startTime: "11:30", endTime: "13:00", dayOfWeek: 5, color: .appWarning)
    ]
}
