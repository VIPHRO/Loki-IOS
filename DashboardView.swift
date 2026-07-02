import SwiftUI

// MARK: - DashboardView
/// Haupt-Dashboard mit Hallo-Name, Datum und direktem Stundenplan.
struct DashboardView: View {
    
    var onBellTap: (() -> Void)? = nil
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                // Header: Hallo, Name + Glocke
                headerSection
                
                // Quick Stats
                quickStatsSection
                
                // Heutiger Stundenplan
                todayScheduleSection
            }
            .padding(.vertical, 20)
        }
        .background(Color.appSurface)
        .navigationBarHidden(true)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hallo, \(viewModel.userName)! 👋")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(viewModel.currentDate)
                        .font(.subheadline)
                        .foregroundColor(.appTextSecondary)
                }
                
                Spacer()
                
                // Notification bell
                Button(action: { onBellTap?() }) {
                    ZStack {
                        Circle()
                            .fill(Color.appCardBackground)
                            .frame(width: 46, height: 46)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            )
                        
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.appPrimary)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Quick Stats
    private var quickStatsSection: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "Übersicht")
            
            HStack(spacing: 12) {
                StatBadge(icon: "chart.bar.fill", value: "1,8", label: "Schnitt", color: .appSuccess)
                StatBadge(icon: "book.fill", value: "8", label: "Fächer", color: .appPrimary)
                StatBadge(icon: "bell.fill", value: "\(viewModel.unreadNotificationsCount)", label: "Mitteilungen", color: .appWarning)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Today's Schedule
    private var todayScheduleSection: some View {
        VStack(spacing: 14) {
            SectionHeader(title: "Heutiger Stundenplan")
            
            if viewModel.todaySchedule.isEmpty {
                emptyScheduleView
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.todaySchedule) { item in
                        TodayScheduleCard(item: item)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - Empty Schedule
    private var emptyScheduleView: some View {
        HStack(spacing: 16) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 28))
                .foregroundColor(.appTextSecondary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Heute kein Unterricht")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Genieße deinen freien Tag! 🎉")
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
        }
        .padding(18)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 20)
    }
}

// MARK: - TodayScheduleCard
/// Kompakte Karte für eine einzelne Unterrichtsstunde im Dashboard
struct TodayScheduleCard: View {
    let item: ScheduleItem
    
    var body: some View {
        HStack(spacing: 14) {
            // Time column
            VStack(spacing: 2) {
                Text(item.startTime)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Rectangle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 1, height: 16)
                
                Text(item.endTime)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(width: 52)
            
            // Color accent bar
            RoundedRectangle(cornerRadius: 2)
                .fill(item.color)
                .frame(width: 3, height: 44)
            
            // Course info
            VStack(alignment: .leading, spacing: 3) {
                Text(item.courseName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("\(item.teacher) · \(item.room)")
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
            
            // Subject icon
            Circle()
                .fill(item.color.opacity(0.2))
                .frame(width: 34, height: 34)
                .overlay(
                    Image(systemName: "book.fill")
                        .font(.system(size: 12))
                        .foregroundColor(item.color)
                )
        }
        .padding(14)
        .background(Color.appCardBackgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        DashboardView()
    }
}
