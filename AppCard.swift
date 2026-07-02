import SwiftUI

// MARK: - AppCard
/// A reusable card component with icon, title, subtitle, and a colored background
struct AppCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let destination: AppDestination
    
    var body: some View {
        NavigationLink(value: destination) {
            HStack(spacing: 16) {
                // Icon container
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.cardTextPrimary)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.cardTextPrimary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.cardTextSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Arrow indicator
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.cardTextSecondary)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                    .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - AppDestination
/// Navigation destinations for the app
enum AppDestination: Hashable {
    case schedule
    case grades
    case announcements
    case notifications
    case settings
    case profile
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appSurface.ignoresSafeArea()
        ScrollView {
            VStack(spacing: 16) {
                AppCard(title: "Stundenplan", subtitle: "Dein aktueller Stundenplan", icon: "calendar", color: .cardSchedule, destination: .schedule)
                AppCard(title: "Noten", subtitle: "Deine Notenübersicht", icon: "chart.bar.fill", color: .cardGrades, destination: .grades)
            }
            .padding()
        }
    }
}
