import SwiftUI

// MARK: - LoginView
/// Login screen with mock authentication.
/// Dark blue theme with floating card design.
struct LoginView: View {
    
    let onLogin: () -> Void
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAnimating = false
    @State private var showError = false
    
    var body: some View {
        ZStack {
            // Background
            Color.appSurface
                .ignoresSafeArea()
            
            // Decorative top glow
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [.appPrimary, .appSecondary]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 340)
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                .ignoresSafeArea()
                .offset(y: -80)
                .opacity(0.85)
                
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer().frame(height: 90)
                    
                    // App Logo
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 90, height: 90)
                                .background(Material.ultraThinMaterial.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            
                            Image(systemName: "graduationcap.fill")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                        }
                        .scaleEffect(isAnimating ? 1.0 : 0.6)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        
                        Text("Willkommen zurück!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .offset(y: isAnimating ? 0 : 10)
                        
                        Text("Melde dich an, um fortzufahren")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .offset(y: isAnimating ? 0 : 10)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Login Form Card
                    VStack(spacing: 20) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("E-Mail")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.appTextSecondary)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.appPrimary)
                                    .frame(width: 20)
                                
                                TextField("max@schule.de", text: $email)
                                    .textContentType(.emailAddress)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.appSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            )
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Passwort")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.appTextSecondary)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.appPrimary)
                                    .frame(width: 20)
                                
                                SecureField("••••••••", text: $password)
                                    .textContentType(.password)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.appSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            )
                        }
                        
                        // Error message
                        if showError {
                            Text("Bitte fülle alle Felder aus.")
                                .font(.caption)
                                .foregroundColor(.appDanger)
                                .transition(.opacity)
                        }
                        
                        // Login Button
                        Button(action: performLogin) {
                            HStack(spacing: 8) {
                                Text("Anmelden")
                                    .fontWeight(.bold)
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14, weight: .bold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.appPrimary, .appSecondary]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .appPrimary.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        
                        // Demo hint
                        Text("Tippe einfach auf 'Anmelden' – es ist nur ein Demo-Prototyp.")
                            .font(.caption2)
                            .foregroundColor(.appTextSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 4)
                    }
                    .padding(24)
                    .background(Color.appCardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.06), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 8)
                    .padding(.horizontal, 24)
                    .offset(y: isAnimating ? 0 : 30)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.15)) {
                isAnimating = true
            }
        }
    }
    
    // MARK: - Actions
    private func performLogin() {
        withAnimation {
            if email.trimmingCharacters(in: .whitespaces).isEmpty || password.isEmpty {
                showError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation { showError = false }
                }
                return
            }
            onLogin()
        }
    }
}

// MARK: - Preview
#Preview {
    LoginView(onLogin: {})
}
