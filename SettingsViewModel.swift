import Foundation
import Combine

// MARK: - SettingsViewModel
/// ViewModel for the Settings screen. Manages app preferences (UI-only for now).
@MainActor
class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isDarkModeEnabled: Bool = false
    @Published var notificationsEnabled: Bool = true
    @Published var gradePushEnabled: Bool = true
    @Published var schedulePushEnabled: Bool = true
    @Published var announcementPushEnabled: Bool = true
    @Published var appVersion: String = "1.0.0"
    
    // MARK: - Initialization
    init() {
        loadSettings()
    }
    
    // MARK: - Public Methods
    func toggleDarkMode() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDarkModeEnabled.toggle()
        }
    }
    
    func toggleNotifications() {
        withAnimation {
            notificationsEnabled.toggle()
        }
    }
    
    func performLogout() {
        // Placeholder: In the future, this will call the auth service
        // For now, the parent view handles navigation back to login
    }
    
    // MARK: - Private Methods
    private func loadSettings() {
        // Load from UserDefaults in the future
        isDarkModeEnabled = false
        notificationsEnabled = true
        gradePushEnabled = true
        schedulePushEnabled = true
        announcementPushEnabled = true
    }
}
