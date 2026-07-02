import SwiftUI

// MARK: - FloatingTabBar
/// iOS 26-inspirierte Floating Tab Bar mit Liquid-Glassmorphismus.
/// Runde, transparente Pill-Form, die über dem Inhalt schwebt.
struct FloatingTabBar: View {
    
    @Binding var selectedTab: Int
    
    private let tabs: [(icon: String, selectedIcon: String, title: String)] = [
        ("house", "house.fill", "Übersicht"),
        ("calendar", "calendar", "Stundenplan"),
        ("chart.bar", "chart.bar.fill", "Noten"),
        ("square.grid.2x2", "square.grid.2x2.fill", "Mehr")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                TabButton(
                    icon: tab.icon,
                    selectedIcon: tab.selectedIcon,
                    title: tab.title,
                    isSelected: selectedTab == index,
                    action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            selectedTab = index
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(tabBarBackground)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.5), radius: 30, x: 0, y: 15)
        .shadow(color: .appPrimary.opacity(0.12), radius: 50, x: 0, y: 10)
        .overlay(
            Capsule()
                .stroke(.white.opacity(0.08), lineWidth: 1)
        )
    }
    
    // MARK: - Tab Bar Background (Liquid Glass)
    private var tabBarBackground: some View {
        ZStack {
            // Deep navy foundation
            Capsule()
                .fill(Color(red: 0.04, green: 0.06, blue: 0.14).opacity(0.85))
            
            // Glass blur overlay – creates the liquid effect
            Capsule()
                .fill(.ultraThinMaterial)
                .opacity(0.6)
            
            // Top highlight rim for depth
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.25),
                            .white.opacity(0.08),
                            .clear,
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            // Blue inner glow border
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [
                            .appPrimary.opacity(0.25),
                            .appSecondary.opacity(0.1),
                            .clear,
                            .appPrimary.opacity(0.06)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
                .blur(radius: 1.5)
            
            // Subtle edge glow
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.05),
                            .clear,
                            .clear,
                            .white.opacity(0.02)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 2
                )
                .blur(radius: 3)
        }
    }
}

// MARK: - TabButton
private struct TabButton: View {
    let icon: String
    let selectedIcon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                // Icon container
                ZStack {
                    // Animated selection highlight
                    if isSelected {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .appPrimary.opacity(0.35),
                                        .appSecondary.opacity(0.15)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 50, height: 32)
                            .shadow(color: .appPrimary.opacity(0.2), radius: 8, x: 0, y: 4)
                            .transition(.opacity.combined(with: .scale(scale: 0.85)))
                    }
                    
                    Image(systemName: isSelected ? selectedIcon : icon)
                        .font(.system(size: 21, weight: isSelected ? .semibold : .regular))
                        .foregroundStyle(isSelected ? Color.appPrimary : Color.white.opacity(0.4))
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .shadow(color: isSelected ? .appPrimary.opacity(0.3) : .clear, radius: 6)
                }
                .frame(width: 54, height: 36)
                
                // Title label
                Text(title)
                    .font(.system(size: 9, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(FloatingTabButtonStyle())
    }
}

// MARK: - FloatingTabButtonStyle
private struct FloatingTabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color(red: 0.035, green: 0.055, blue: 0.110)
            .ignoresSafeArea()
        
        VStack {
            Spacer()
            FloatingTabBar(selectedTab: .constant(0))
                .environment(\.colorScheme, .dark)
        }
    }
}
