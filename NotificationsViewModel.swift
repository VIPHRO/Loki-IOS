import Foundation
import Combine

// MARK: - NotificationsViewModel
/// ViewModel for the Notifications screen. Manages notification data and read status.
@MainActor
class NotificationsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var notifications: [NotificationItem] = []
    @Published var selectedFilter: NotificationFilter = .all
    
    enum NotificationFilter: String, CaseIterable {
        case all = "Alle"
        case unread = "Ungelesen"
        case grade = "Noten"
        case schedule = "Stundenplan"
        case announcement = "Aushänge"
        
        var icon: String {
            switch self {
            case .all: return "tray.fill"
            case .unread: return "bell.fill"
            case .grade: return "bookmark.fill"
            case .schedule: return "calendar"
            case .announcement: return "megaphone.fill"
            }
        }
    }
    
    // MARK: - Computed Properties
    var filteredNotifications: [NotificationItem] {
        switch selectedFilter {
        case .all:
            return notifications
        case .unread:
            return notifications.filter { !$0.isRead }
        case .grade:
            return notifications.filter { $0.category == .grade }
        case .schedule:
            return notifications.filter { $0.category == .schedule }
        case .announcement:
            return notifications.filter { $0.category == .announcement }
        }
    }
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    // MARK: - Initialization
    init() {
        loadNotifications()
    }
    
    // MARK: - Public Methods
    func selectFilter(_ filter: NotificationFilter) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedFilter = filter
        }
    }
    
    func markAsRead(_ notification: NotificationItem) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index].isRead = true
        }
    }
    
    func markAllAsRead() {
        for index in notifications.indices {
            notifications[index].isRead = true
        }
    }
    
    // MARK: - Private Methods
    private func loadNotifications() {
        notifications = NotificationItem.mockNotifications
    }
}
