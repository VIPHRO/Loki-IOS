import SwiftUI

// MARK: - FilterChip
/// A reusable capsule-shaped filter/tag button component
struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .bold : .medium)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.appPrimary : Color.appCardBackground)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.06), lineWidth: isSelected ? 0 : 1)
                    )
            )
            .foregroundColor(isSelected ? .white : .appTextSecondary)
            .shadow(color: isSelected ? .appPrimary.opacity(0.3) : .black.opacity(0.2),
                    radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appSurface.ignoresSafeArea()
        HStack(spacing: 10) {
            FilterChip(title: "Alle", icon: "tray.fill", isSelected: true, action: {})
            FilterChip(title: "Noten", icon: "bookmark.fill", isSelected: false, action: {})
            FilterChip(title: "Aushänge", icon: "megaphone.fill", isSelected: false, action: {})
        }
        .padding()
    }
}
