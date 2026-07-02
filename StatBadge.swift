import SwiftUI

// MARK: - StatBadge
/// A small badge showing a statistic with icon and value
struct StatBadge: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appSurface.ignoresSafeArea()
        HStack(spacing: 16) {
            StatBadge(icon: "chart.bar.fill", value: "1,8", label: "Schnitt", color: .appSuccess)
            StatBadge(icon: "book.fill", value: "12", label: "Fächer", color: .appPrimary)
            StatBadge(icon: "clock.fill", value: "35", label: "Std./Woche", color: .appWarning)
        }
        .padding()
    }
}
