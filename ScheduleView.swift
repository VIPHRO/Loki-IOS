import SwiftUI

// MARK: - ScheduleView
/// Displays the weekly schedule with day selection tabs
struct ScheduleView: View {
    
    @StateObject private var viewModel = ScheduleViewModel()
    
    // MARK: - Computed Properties
    private var currentWeekNumber: Int {
        Calendar.current.component(.weekOfYear, from: Date())
    }
    
    private var currentSchoolYear: String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        if month >= 8 {
            return "\(year)/\(year + 1 - 2000)"
        } else {
            return "\(year - 1)/\(year - 2000)"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerSection
            
            // Day selector
            daySelectorSection
            
            // Schedule list
            scheduleListSection
        }
        .background(Color.appSurface)
        .navigationBarHidden(true)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Stundenplan")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Woche \(currentWeekNumber) • Schuljahr \(currentSchoolYear)")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    // MARK: - Day Selector
    private var daySelectorSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.days, id: \.number) { day in
                    dayButton(day: day)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
    
    private func dayButton(day: (number: Int, name: String)) -> some View {
        let isSelected = viewModel.selectedDay == day.number
        let isToday = isCurrentDay(day.number)
        
        return Button {
            viewModel.selectDay(day.number)
        } label: {
            VStack(spacing: 6) {
                Text(String(day.name.prefix(2)))
                    .font(.caption)
                    .fontWeight(isSelected ? .bold : .medium)
                
                Circle()
                    .fill(Color.appPrimary)
                    .frame(width: 6, height: 6)
                    .opacity(isToday ? 1 : 0)
            }
            .frame(width: 56, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.appPrimary : Color.appCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.06), lineWidth: isSelected ? 0 : 1)
                    )
            )
            .foregroundColor(isSelected ? .white : .appTextSecondary)
            .shadow(color: isSelected ? .appPrimary.opacity(0.3) : .black.opacity(0.2),
                    radius: isSelected ? 8 : 4, x: 0, y: isSelected ? 4 : 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func isCurrentDay(_ dayNumber: Int) -> Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        let adjusted = today == 1 ? 1 : today - 1
        return adjusted == dayNumber
    }
    
    // MARK: - Schedule List
    private var scheduleListSection: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                // Day name header
                HStack {
                    Text(viewModel.dayName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(viewModel.filteredItems.count) Unterrichtsstunden")
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                
                if viewModel.filteredItems.isEmpty {
                    emptyStateView
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredItems) { item in
                            ScheduleCard(item: item)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 40)
            
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 48))
                .foregroundColor(.appTextSecondary)
            
            Text("Kein Unterricht an diesem Tag")
                .font(.headline)
                .foregroundColor(.appTextSecondary)
            
            Text("Genieße deinen freien Tag! 🎉")
                .font(.subheadline)
                .foregroundColor(.appTextTertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
}

// MARK: - ScheduleCard
/// A single schedule entry card
struct ScheduleCard: View {
    let item: ScheduleItem
    
    var body: some View {
        HStack(spacing: 16) {
            // Time column
            VStack(spacing: 4) {
                Text(item.startTime)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Rectangle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 1, height: 20)
                
                Text(item.endTime)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(width: 60)
            
            // Color indicator
            RoundedRectangle(cornerRadius: 4)
                .fill(item.color)
                .frame(width: 4)
            
            // Course details
            VStack(alignment: .leading, spacing: 6) {
                Text(item.courseName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    Label(item.teacher, systemImage: "person.fill")
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                    
                    Label(item.room, systemImage: "door.left.hand.open")
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                }
            }
            
            Spacer()
            
            // Color circle
            Circle()
                .fill(item.color.opacity(0.2))
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "book.fill")
                        .font(.system(size: 14))
                        .foregroundColor(item.color)
                )
        }
        .padding(16)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ScheduleView()
    }
}
