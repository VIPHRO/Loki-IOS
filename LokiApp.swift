import SwiftUI

// MARK: - AppPhase
/// Tracks the current phase of the app lifecycle
enum AppPhase {
    case splash
    case login
    case authenticated
}

// MARK: - LokiApp
/// The main entry point for the Loki iOS app.
/// Manages the app lifecycle and initial navigation.
@main
struct LokiApp: App {
    
    @State private var appPhase: AppPhase = .splash
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            switch appPhase {
            case .splash:
                SplashScreenView(onFinished: {
                    appPhase = .login
                })
            case .login:
                LoginView(onLogin: {
                    appPhase = .authenticated
                })
            case .authenticated:
                MainTabView(onLogout: {
                    appPhase = .login
                })
            }
        }
    }
}
