import SwiftUI

// MARK: - SectionHeader
/// A reusable section header with title and optional action button
struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            if let actionTitle, let action {
                Button(action: action) {
                    HStack(spacing: 4) {
                        Text(actionTitle)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .foregroundColor(.appPrimary)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appSurface.ignoresSafeArea()
        VStack(spacing: 16) {
            SectionHeader(title: "Meine Fächer")
            SectionHeader(title: "Stundenplan", actionTitle: "Alle anzeigen", action: {})
        }
        .padding(.vertical)
    }
}
