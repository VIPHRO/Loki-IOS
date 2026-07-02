import SwiftUI

// MARK: - GradesView
/// Displays grades with course averages and a detailed list
struct GradesView: View {
    
    @StateObject private var viewModel = GradesViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerSection
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Overall average card
                    averageCard
                    
                    // Course averages
                    courseAveragesSection
                    
                    // Filter chips
                    filterSection
                    
                    // Grade list
                    gradeListSection
                }
                .padding(.bottom, 20)
            }
        }
        .background(Color.appSurface)
        .navigationBarHidden(true)
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Noten")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Aktueller Notenspiegel")
                .font(.subheadline)
                .foregroundColor(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    // MARK: - Average Card
    private var averageCard: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 8) {
                Text(String(format: "%.1f", viewModel.overallAverage))
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundColor(averageColor)
                
                Text("Gesamtdurchschnitt")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.appTextSecondary)
                
                Text("\(viewModel.grades.count) Noten")
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 24)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
    
    private var averageColor: Color {
        if viewModel.overallAverage <= 1.5 { return .appSuccess }
        if viewModel.overallAverage <= 2.5 { return .appPrimary }
        if viewModel.overallAverage <= 3.5 { return .appWarning }
        return .appDanger
    }
    
    // MARK: - Course Averages
    private var courseAveragesSection: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "Fachübersicht", actionTitle: viewModel.selectedCourse != nil ? "Alle anzeigen" : nil) {
                viewModel.selectCourse(nil)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.courseAverages) { course in
                        CourseAverageCard(
                            course: course,
                            isSelected: viewModel.selectedCourse == course.courseName
                        )
                        .onTapGesture {
                            if viewModel.selectedCourse == course.courseName {
                                viewModel.selectCourse(nil)
                            } else {
                                viewModel.selectCourse(course.courseName)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - Filter
    private var filterSection: some View {
        Group {
            if viewModel.selectedCourse != nil {
                HStack {
                    Text("Gefiltert: \(viewModel.selectedCourse ?? "")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.appPrimary)
                    
                    Spacer()
                    
                    Text("Schnitt: \(viewModel.selectedCourseAverage)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
            }
        }
    }
    
    // MARK: - Grade List
    private var gradeListSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.filteredGrades.sorted(by: { $0.date > $1.date })) { grade in
                GradeCard(grade: grade)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - CourseAverageCard
struct CourseAverageCard: View {
    let course: CourseAverage
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text(course.courseName.prefix(2))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(course.color)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
            Text(String(format: "%.1f", course.average))
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("\(course.gradeCount) \(course.gradeCount == 1 ? "Note" : "Noten")")
                .font(.caption2)
                .foregroundColor(.appTextSecondary)
        }
        .frame(width: 90)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isSelected ? course.color.opacity(0.15) : Color.appCardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? course.color : Color.white.opacity(0.05), lineWidth: isSelected ? 2 : 1)
                )
        )
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

// MARK: - GradeCard
struct GradeCard: View {
    let grade: GradeItem
    
    var body: some View {
        HStack(spacing: 14) {
            // Grade value
            ZStack {
                Circle()
                    .fill(gradeColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Text(String(format: "%.1f", grade.grade))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(gradeColor)
            }
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(grade.courseName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    Label(grade.type.rawValue, systemImage: grade.type.icon)
                        .font(.caption)
                        .foregroundColor(.appTextSecondary)
                    
                    if let note = grade.note {
                        Text("•")
                            .font(.caption)
                            .foregroundColor(.appTextTertiary)
                        
                        Text(note)
                            .font(.caption)
                            .foregroundColor(.appTextSecondary)
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()
            
            // Date
            Text(grade.date, style: .date)
                .font(.caption2)
                .foregroundColor(.appTextSecondary)
        }
        .padding(14)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
    
    private var gradeColor: Color {
        if grade.grade <= 1.5 { return .appSuccess }
        if grade.grade <= 2.5 { return .appPrimary }
        if grade.grade <= 3.5 { return .appWarning }
        return .appDanger
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GradesView()
    }
}
