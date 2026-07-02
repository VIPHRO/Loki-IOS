import Foundation
import Combine

// MARK: - DashboardViewModel
/// ViewModel for the Dashboard screen. Manages mock data and navigation state.
@MainActor
class DashboardViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var userName: String = "Max"
    @Published var currentDate: String = ""
    @Published var nextClassInfo: String = ""
    @Published var unreadNotificationsCount: Int = 0
    @Published var todaySchedule: [ScheduleItem] = []
    
    // MARK: - Initialization
    init() {
        updateDateInfo()
        loadTodaySchedule()
        loadUnreadCount()
    }
    
    // MARK: - Private Methods
    private func updateDateInfo() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "EEEE, d. MMMM yyyy"
        currentDate = formatter.string(from: Date()).capitalized
    }
    
    private func loadTodaySchedule() {
        let today = Calendar.current.component(.weekday, from: Date())
        let dayOfWeek = today == 1 ? 1 : today - 1
        let adjustedDay = dayOfWeek < 1 ? 1 : min(dayOfWeek, 5)
        
        let schedule = ScheduleItem.mockSchedule
            .filter { $0.dayOfWeek == adjustedDay }
            .sorted { $0.startTime < $1.startTime }
        
        todaySchedule = schedule
        
        if let first = schedule.first {
            nextClassInfo = "\(first.courseName) um \(first.startTime)"
        } else {
            nextClassInfo = "Heute kein Unterricht"
        }
    }
    
    private func loadUnreadCount() {
        unreadNotificationsCount = NotificationItem.mockNotifications.filter { !$0.isRead }.count
    }
}
