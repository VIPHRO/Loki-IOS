import SwiftUI

// MARK: - NotificationsView
/// Displays in-app notifications with filter options
struct NotificationsView: View {
    
    @StateObject private var viewModel = NotificationsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerSection
            
            // Filter tabs
            filterSection
            
            // Notification list
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    if viewModel.filteredNotifications.isEmpty {
                        emptyStateView
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.filteredNotifications.sorted(by: { $0.date > $1.date })) { notification in
                                NotificationCard(
                                    notification: notification,
                                    onTap: { viewModel.markAsRead(notification) }
                                )
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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Mitteilungen")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("\(viewModel.unreadCount) ungelesen")
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
            
            // Mark all read button
            if viewModel.unreadCount > 0 {
                Button(action: viewModel.markAllAsRead) {
                    Text("Alle gelesen")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.appPrimary)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    // MARK: - Filter
    private var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(NotificationsViewModel.NotificationFilter.allCases, id: \.self) { filter in
                    FilterChip(
                        title: filter.rawValue,
                        icon: filter.icon,
                        isSelected: viewModel.selectedFilter == filter
                    ) {
                        viewModel.selectFilter(filter)
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
            
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 48))
                .foregroundColor(.appTextSecondary)
            
            Text("Keine Mitteilungen")
                .font(.headline)
                .foregroundColor(.appTextSecondary)
            
            Text("Hier erscheinen deine Benachrichtigungen")
                .font(.subheadline)
                .foregroundColor(.appTextTertiary)
        }
    }
}

// MARK: - NotificationCard
struct NotificationCard: View {
    let notification: NotificationItem
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                // Unread indicator + icon
                ZStack {
                    Circle()
                        .fill(categoryColor.opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: notification.category.icon)
                        .font(.system(size: 16))
                        .foregroundColor(categoryColor)
                }
                .overlay(
                    Circle()
                        .fill(notification.isRead ? Color.clear : .appPrimary)
                        .frame(width: 12, height: 12)
                        .offset(x: 16, y: -16)
                )
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(.subheadline)
                        .fontWeight(notification.isRead ? .medium : .bold)
                        .foregroundColor(.white)
                    
                    Text(notification.message)
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                        .lineLimit(2)
                    
                    Text(notification.date, style: .relative)
                        .font(.caption2)
                        .foregroundColor(.appTextTertiary)
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.appTextTertiary)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.appCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(notification.isRead ? Color.white.opacity(0.05) : Color.appPrimary.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var categoryColor: Color {
        switch notification.category {
        case .grade: return .appSuccess
        case .schedule: return .cardSchedule
        case .announcement: return .cardAnnouncements
        case .reminder: return .cardNotifications
        case .system: return .cardSettings
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        NotificationsView()
    }
}
