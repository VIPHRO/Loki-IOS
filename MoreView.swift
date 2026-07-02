import SwiftUI

// MARK: - MoreView
/// "Mehr" Tab – zeigt alle weiteren Navigationsziele an
struct MoreView: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                headerSection
                
                // Navigation Options
                optionsSection
            }
            .padding(.vertical, 20)
        }
        .background(Color.appSurface)
        .navigationBarHidden(true)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mehr")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Alle weiteren Funktionen")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
    
    // MARK: - Options
    private var optionsSection: some View {
        VStack(spacing: 14) {
            MoreCard(
                title: "Aushänge",
                subtitle: "Alle aktuellen Mitteilungen und Ankündigungen",
                icon: "megaphone.fill",
                color: .cardAnnouncements,
                destination: .announcements
            )
            
            MoreCard(
                title: "Benachrichtigungen",
                subtitle: "Verpasse keine wichtigen Updates mehr",
                icon: "bell.fill",
                color: .cardNotifications,
                destination: .notifications
            )
            
            MoreCard(
                title: "Profil",
                subtitle: "Deine persönlichen Daten und Statistiken",
                icon: "person.fill",
                color: .appSecondary,
                destination: .profile
            )
            
            MoreCard(
                title: "Einstellungen",
                subtitle: "App-Einstellungen und Präferenzen",
                icon: "gearshape.fill",
                color: .cardSettings,
                destination: .settings
            )
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - MoreCard
private struct MoreCard: View {
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
                        .foregroundColor(.white)
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

// MARK: - Preview
#Preview {
    NavigationStack {
        MoreView()
    }
}
