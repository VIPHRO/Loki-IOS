import SwiftUI

// MARK: - ProfileView
/// Displays the user's profile information
struct ProfileView: View {
    
    let profile = UserProfile.mockProfile
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Profile header
                profileHeaderSection
                
                // Info cards
                infoSection
                
                // Stats section
                statsSection
            }
            .padding(.vertical, 20)
        }
        .background(Color.appSurface)
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Profile Header
    private var profileHeaderSection: some View {
        VStack(spacing: 16) {
            // Avatar with gradient
            AvatarView(initials: profile.avatarInitials, size: 90)
            
            VStack(spacing: 4) {
                Text(profile.fullName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(profile.email)
                    .font(.subheadline)
                    .foregroundColor(.appTextSecondary)
            }
            
            // Grade & School badges
            HStack(spacing: 12) {
                Label(profile.grade, systemImage: "graduationcap.fill")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.appPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.appPrimary.opacity(0.15))
                    .clipShape(Capsule())
                
                Label(profile.school, systemImage: "building.columns.fill")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.appSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.appSecondary.opacity(0.15))
                    .clipShape(Capsule())
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Info Section
    private var infoSection: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Kontaktdaten")
                .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                ProfileRow(icon: "envelope.fill", title: "E-Mail", value: profile.email)
                ProfileDivider()
                ProfileRow(icon: "person.text.rectangle.fill", title: "Schüler-ID", value: profile.studentId)
                ProfileDivider()
                ProfileRow(icon: "graduationcap.fill", title: "Klasse", value: profile.grade)
                ProfileDivider()
                ProfileRow(icon: "building.columns.fill", title: "Schule", value: profile.school)
            }
            .padding(4)
            .background(Color.appCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "Statistiken")
            
            HStack(spacing: 12) {
                StatBadge(icon: "book.fill", value: "8", label: "Fächer", color: .appPrimary)
                StatBadge(icon: "clock.fill", value: "35", label: "Std./Woche", color: .appWarning)
                StatBadge(icon: "chart.bar.fill", value: "1,8", label: "Schnitt", color: .appSuccess)
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - ProfileDivider
private struct ProfileDivider: View {
    var body: some View {
        Divider()
            .padding(.leading, 46)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ProfileView()
    }
}
