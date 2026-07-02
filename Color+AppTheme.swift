import SwiftUI

// MARK: - App Theme Colors
extension Color {
    
    // MARK: - Primary Colors
    static let appPrimary = Color(red: 0.24, green: 0.51, blue: 0.96) // #3B82F6
    static let appSecondary = Color(red: 0.45, green: 0.40, blue: 0.95) // #7366F2
    static let appSuccess = Color(red: 0.20, green: 0.82, blue: 0.45) // #33D16E
    static let appWarning = Color(red: 1.0, green: 0.68, blue: 0.18) // #FFAE2E
    static let appDanger = Color(red: 1.0, green: 0.32, blue: 0.32) // #FF5252
    
    // MARK: - Card Colors
    static let cardSchedule = Color(red: 0.24, green: 0.51, blue: 0.96) // #3B82F6
    static let cardGrades = Color(red: 0.20, green: 0.82, blue: 0.45) // #33D16E
    static let cardAnnouncements = Color(red: 1.0, green: 0.68, blue: 0.18) // #FFAE2E
    static let cardNotifications = Color(red: 0.60, green: 0.38, blue: 0.98) // #9961FA
    static let cardSettings = Color(red: 0.48, green: 0.51, blue: 0.58) // #7B8294
    
    // MARK: - Surface Colors (Dark Navy Blue Theme)
    static let appSurface = Color(red: 0.035, green: 0.055, blue: 0.110) // #090E1C
    static let appSurfaceSecondary = Color(red: 0.055, green: 0.078, blue: 0.145) // #0E1425
    static let appCardBackground = Color(red: 0.078, green: 0.106, blue: 0.180) // #141B2E
    static let appCardBackgroundSecondary = Color(red: 0.102, green: 0.133, blue: 0.216) // #1A2237
    
    static let appTextPrimary = Color.white
    static let appTextSecondary = Color.white.opacity(0.55)
    static let appTextTertiary = Color.white.opacity(0.32)
    
    static let appDivider = Color.white.opacity(0.08)
    static let appStroke = Color.white.opacity(0.06)
    
    // MARK: - Text Colors for Cards (always white or light)
    static let cardTextPrimary = Color.white
    static let cardTextSecondary = Color.white.opacity(0.8)
}
