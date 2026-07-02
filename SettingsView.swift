import SwiftUI

// MARK: - SettingsView
/// Settings screen with toggles and logout button
struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    let onLogout: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Header
                headerSection
                
                // Appearance
                appearanceSection
                
                // Notifications
                notificationSection
                
                // About
                aboutSection
                
                // Logout
                logoutSection
            }
            .padding(.vertical, 20)
        }
        .background(Color.appSurface)
        .navigationTitle("Einstellungen")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 4) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 40))
                .foregroundColor(.appPrimary)
                .padding(.bottom, 8)
            
            Text("Einstellungen")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Passe die App nach deinen Wünschen an")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }
    
    // MARK: - Appearance Section
    private var appearanceSection: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Darstellung")
                .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                SettingsToggleRow(
                    icon: "moon.fill",
                    iconColor: .appSecondary,
                    title: "Dark Mode",
                    subtitle: "Das Design ist fest im dunklen Thema gestaltet",
                    isOn: $viewModel.isDarkModeEnabled
                )
                .disabled(true)
                .opacity(0.5)
            }
            .padding(4)
            .background(Color.appCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Notifications Section
    private var notificationSection: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Benachrichtigungen")
                .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                SettingsToggleRow(
                    icon: "bell.badge.fill",
                    iconColor: .appWarning,
                    title: "Push-Benachrichtigungen",
                    subtitle: "Alle Mitteilungen empfangen",
                    isOn: $viewModel.notificationsEnabled
                )
                
                Divider()
                    .padding(.leading, 52)
                
                SettingsToggleRow(
                    icon: "bookmark.fill",
                    iconColor: .appSuccess,
                    title: "Noten-Updates",
                    subtitle: "Bei neuen Noten benachrichtigen",
                    isOn: $viewModel.gradePushEnabled
                )
                .opacity(viewModel.notificationsEnabled ? 1 : 0.4)
                .disabled(!viewModel.notificationsEnabled)
                
                Divider()
                    .padding(.leading, 52)
                
                SettingsToggleRow(
                    icon: "calendar",
                    iconColor: .cardSchedule,
                    title: "Stundenplan-Änderungen",
                    subtitle: "Bei Planänderungen benachrichtigen",
                    isOn: $viewModel.schedulePushEnabled
                )
                .opacity(viewModel.notificationsEnabled ? 1 : 0.4)
                .disabled(!viewModel.notificationsEnabled)
                
                Divider()
                    .padding(.leading, 52)
                
                SettingsToggleRow(
                    icon: "megaphone.fill",
                    iconColor: .cardAnnouncements,
                    title: "Aushänge",
                    subtitle: "Bei neuen Aushängen benachrichtigen",
                    isOn: $viewModel.announcementPushEnabled
                )
                .opacity(viewModel.notificationsEnabled ? 1 : 0.4)
                .disabled(!viewModel.notificationsEnabled)
            }
            .padding(4)
            .background(Color.appCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - About Section
    private var aboutSection: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Info")
                .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                SettingsInfoRow(icon: "info.circle.fill", iconColor: .appPrimary, title: "Version", value: viewModel.appVersion)
                Divider()
                    .padding(.leading, 52)
                SettingsInfoRow(icon: "doc.text.fill", iconColor: .appSecondary, title: "Lizenz", value: "MIT")
                Divider()
                    .padding(.leading, 52)
                SettingsInfoRow(icon: "lock.fill", iconColor: .appSuccess, title: "Datenschutz", value: "DSGVO-konform")
            }
            .padding(4)
            .background(Color.appCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Logout Section
    private var logoutSection: some View {
        VStack(spacing: 12) {
            Button(action: performLogout) {
                HStack(spacing: 10) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 16, weight: .bold))
                    
                    Text("Abmelden")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundColor(.appDanger)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.appDanger, lineWidth: 2)
                )
            }
            .padding(.horizontal, 20)
            
            Text("Du wirst zum Anmeldebildschirm zurückgeleitet.")
                .font(.caption2)
                .foregroundColor(.appTextSecondary)
        }
    }
    
    // MARK: - Actions
    private func performLogout() {
        viewModel.performLogout()
        onLogout()
    }
}

// MARK: - SettingsToggleRow
struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(iconColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .tint(.appPrimary)
                .labelsHidden()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}

// MARK: - SettingsInfoRow
struct SettingsInfoRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(iconColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(title)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsView(onLogout: {})
    }
}
