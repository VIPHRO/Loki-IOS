import Foundation

// MARK: - UserProfile Model
/// Represents the current user's profile information
struct UserProfile: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let email: String
    let studentId: String
    let grade: String
    let school: String
    let avatarInitials: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    static let mockProfile = UserProfile(
        firstName: "Max",
        lastName: "Mustermann",
        email: "max.mustermann@schule.de",
        studentId: "ST-2024-0042",
        grade: "12a",
        school: "Gymnasium am Stadtpark",
        avatarInitials: "MM"
    )
}
