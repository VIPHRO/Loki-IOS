import SwiftUI

// MARK: - MainTabView
/// The main tab interface shown after login.
/// Uses a custom iOS 26-inspired floating liquid tab bar.
struct MainTabView: View {
    
    let onLogout: () -> Void
    @State private var selectedTab = 0
    @State private var showNotifications = false
    @State private var navigationPath = NavigationPath()
    
    // Tabs: 0=Übersicht, 1=Stundenplan, 2=Noten, 3=Mehr
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .bottom) {
                // Tab content
                tabContent
                    .ignoresSafeArea(.keyboard)
                
                // Floating Tab Bar overlay
                FloatingTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 28)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .navigationDestination(for: AppDestination.self) { destination in
                destinationView(for: destination)
                    .toolbar(.hidden, for: .tabBar)
            }
            .fullScreenCover(isPresented: $showNotifications) {
                NavigationStack {
                    NotificationsView()
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Schließen") {
                                    showNotifications = false
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(.appPrimary)
                            }
                        }
                }
            }
        }
        .onAppear(perform: configureNavigationBar)
    }
    
    // MARK: - Configure Navigation Bar Appearance
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    // MARK: - Tab Content
    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case 0:
            DashboardView(onBellTap: { showNotifications = true })
        case 1:
            ScheduleView()
        case 2:
            GradesView()
        case 3:
            MoreView()
        default:
            DashboardView(onBellTap: { showNotifications = true })
        }
    }
    
    // MARK: - Navigation Destinations
    @ViewBuilder
    private func destinationView(for destination: AppDestination) -> some View {
        switch destination {
        case .schedule:
            ScheduleView()
        case .grades:
            GradesView()
        case .announcements:
            AnnouncementsView()
        case .notifications:
            NotificationsView()
        case .settings:
            SettingsView(onLogout: onLogout)
        case .profile:
            ProfileView()
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView(onLogout: {})
}
