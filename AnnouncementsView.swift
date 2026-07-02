import SwiftUI

// MARK: - AnnouncementsView
/// Displays school announcements and notices
struct AnnouncementsView: View {
    
    @State private var announcements = Announcement.mockAnnouncements
    @State private var selectedCategory: Announcement.AnnouncementCategory? = nil
    
    var filteredAnnouncements: [Announcement] {
        if let category = selectedCategory {
            return announcements.filter { $0.category == category }
        }
        return announcements
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerSection
            
            // Category filter
            filterSection
            
            // Announcements list
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    if filteredAnnouncements.isEmpty {
                        emptyStateView
                    } else {
                        LazyVStack(spacing: 14) {
                            ForEach(filteredAnnouncements.sorted(by: { $0.date > $1.date })) { announcement in
                                AnnouncementCard(announcement: announcement)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .background(Color.appSurface)
        .navigationBarHidden(true)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Aushänge")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("\(filteredAnnouncements.count) Mitteilungen")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    // MARK: - Filter
    private var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                FilterChip(title: "Alle", icon: "tray.fill", isSelected: selectedCategory == nil) {
                    withAnimation { selectedCategory = nil }
                }
                
                ForEach(Announcement.AnnouncementCategory.allCases, id: \.self) { category in
                    FilterChip(
                        title: category.rawValue,
                        icon: category.icon,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 60)
            
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundColor(.appTextSecondary)
            
            Text("Keine Aushänge in dieser Kategorie")
                .font(.headline)
                .foregroundColor(.appTextSecondary)
        }
    }
}
// MARK: - AnnouncementCard
struct AnnouncementCard: View {
    let announcement: Announcement
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header row
            HStack(spacing: 12) {
                // Category icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(announcement.isUrgent ? Color.appDanger : categoryColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: announcement.category.icon)
                        .font(.system(size: 16))
                        .foregroundColor(announcement.isUrgent ? .appDanger : categoryColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(announcement.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 6) {
                        Text(announcement.author)
                            .font(.caption)
                            .foregroundColor(.appTextSecondary)
                        
                        Text("•")
                            .font(.caption)
                            .foregroundColor(.appTextTertiary)
                        
                        Text(announcement.date, style: .relative)
                            .font(.caption)
                            .foregroundColor(.appTextSecondary)
                    }
                }
                
                Spacer()
                
                if announcement.isUrgent {
                    Text("Eilig")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.appDanger)
                        .clipShape(Capsule())
                }
            }
            
            // Content
            Text(announcement.content)
                .font(.body)
                .foregroundColor(.appTextSecondary)
                .lineLimit(isExpanded ? nil : 3)
            
            // Read more / less button
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                Text(isExpanded ? "Weniger anzeigen" : "Mehr anzeigen")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.appPrimary)
            }
        }
        .padding(16)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
    
    private var categoryColor: Color {
        switch announcement.category {
        case .general: return .appPrimary
        case .schoolEvents: return .appSecondary
        case .sports: return .appSuccess
        case .exams: return .appWarning
        case .clubs: return .cardNotifications
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AnnouncementsView()
    }
}
