import SwiftUI
import Foundation
import Combine

// MARK: - GradesViewModel
/// ViewModel for the Grades screen. Manages grade data and computed averages.
@MainActor
class GradesViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var grades: [GradeItem] = []
    @Published var selectedCourse: String? = nil
    
    // MARK: - Computed Properties
    var courses: [String] {
        Array(Set(grades.map { $0.courseName })).sorted()
    }
    
    var filteredGrades: [GradeItem] {
        if let course = selectedCourse {
            return grades.filter { $0.courseName == course }
        }
        return grades
    }
    
    var overallAverage: Double {
        let allGrades = grades.map { $0.grade }
        guard !allGrades.isEmpty else { return 0 }
        let avg = allGrades.reduce(0, +) / Double(allGrades.count)
        return (avg * 10).rounded() / 10
    }
    
    var courseAverages: [CourseAverage] {
        let colors: [Color] = [.cardSchedule, .appSuccess, .appWarning, .cardNotifications, .appSecondary, .cardAnnouncements]
        return courses.enumerated().map { (index, course) in
            let courseGrades = grades.filter { $0.courseName == course }
            let avg = courseGrades.map { $0.grade }.reduce(0, +) / Double(courseGrades.count)
            let rounded = (avg * 10).rounded() / 10
            return CourseAverage(courseName: course, average: rounded, gradeCount: courseGrades.count, color: colors[index % colors.count])
        }
    }
    
    var selectedCourseAverage: String {
        guard let course = selectedCourse else { return String(format: "%.1f", overallAverage) }
        let courseGrades = grades.filter { $0.courseName == course }
        let avg = courseGrades.map { $0.grade }.reduce(0, +) / Double(courseGrades.count)
        return String(format: "%.1f", (avg * 10).rounded() / 10)
    }
    
    // MARK: - Initialization
    init() {
        loadGrades()
    }
    
    // MARK: - Public Methods
    func selectCourse(_ course: String?) {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedCourse = course
        }
    }
    
    // MARK: - Private Methods
    private func loadGrades() {
        grades = GradeItem.mockGrades
    }
}
