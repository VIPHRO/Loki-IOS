import SwiftUI

// MARK: - AvatarView
/// A circular avatar view showing initials on a colored background
struct AvatarView: View {
    let initials: String
    var size: CGFloat = 60
    
    private var gradientColors: [Color] {
        let hash = initials.hash & 0x7FFFFFFF // mask to positive
        let colors: [[Color]] = [
            [.appPrimary, .appSecondary],
            [.cardGrades, .appSuccess],
            [.cardNotifications, .appSecondary],
            [.cardAnnouncements, .appWarning],
            [.cardSchedule, .appPrimary],
            [.appSecondary, .cardNotifications]
        ]
        return colors[hash % colors.count]
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: size, height: size)
            .clipShape(Circle())
            .shadow(color: gradientColors[0].opacity(0.3), radius: 8, x: 0, y: 4)
            
            Text(initials)
                .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

// MARK: - ProfileRow
/// A reusable profile info row with icon and text
struct ProfileRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.appPrimary)
                .frame(width: 32, height: 32)
                .background(Color.appPrimary.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
                
                Text(value)
                    .font(.body)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appSurface.ignoresSafeArea()
        VStack(spacing: 20) {
            AvatarView(initials: "MM", size: 80)
            ProfileRow(icon: "envelope.fill", title: "E-Mail", value: "max@schule.de")
            ProfileRow(icon: "graduationcap.fill", title: "Klasse", value: "12a")
        }
        .padding()
    }
}
