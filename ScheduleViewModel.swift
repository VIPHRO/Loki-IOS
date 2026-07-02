import Foundation
import Combine

// MARK: - ScheduleViewModel
/// ViewModel for the Schedule screen. Provides filtered and grouped schedule data.
@MainActor
class ScheduleViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var scheduleItems: [ScheduleItem] = []
    @Published var selectedDay: Int = 1
    @Published var days: [(number: Int, name: String)] = []
    
    // MARK: - Computed Properties
    var filteredItems: [ScheduleItem] {
        scheduleItems.filter { $0.dayOfWeek == selectedDay }
            .sorted { $0.startTime < $1.startTime }
    }
    
    var dayName: String {
        days.first(where: { $0.number == selectedDay })?.name ?? ""
    }
    
    // MARK: - Initialization
    init() {
        loadDays()
        loadSchedule()
        setCurrentDay()
    }
    
    // MARK: - Public Methods
    func selectDay(_ day: Int) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            selectedDay = day
        }
    }
    
    // MARK: - Private Methods
    private func loadDays() {
        days = [
            (1, "Montag"),
            (2, "Dienstag"),
            (3, "Mittwoch"),
            (4, "Donnerstag"),
            (5, "Freitag")
        ]
    }
    
    private func loadSchedule() {
        scheduleItems = ScheduleItem.mockSchedule
    }
    
    private func setCurrentDay() {
        let today = Calendar.current.component(.weekday, from: Date())
        let dayOfWeek = today == 1 ? 1 : today - 1 // Sunday = 1 -> Monday
        selectedDay = dayOfWeek < 1 ? 1 : (dayOfWeek > 5 ? 5 : dayOfWeek)
    }
}
