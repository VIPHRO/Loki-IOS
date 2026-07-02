import SwiftUI

// MARK: - SplashScreenView
/// The initial splash screen shown when the app launches
struct SplashScreenView: View {
    
    let onFinished: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Dark navy background
            Color.appSurface
                .ignoresSafeArea()
            
            // Animated gradient glow
            LinearGradient(
                gradient: Gradient(colors: [.appPrimary, .appSecondary]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 500, height: 500)
            .clipShape(Circle())
            .blur(radius: 120)
            .opacity(0.3)
            .offset(x: -50, y: -80)
            
            // Secondary glow
            LinearGradient(
                gradient: Gradient(colors: [.appSecondary, .appPrimary]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 400, height: 400)
            .clipShape(Circle())
            .blur(radius: 100)
            .opacity(0.2)
            .offset(x: 120, y: 200)
            
            VStack(spacing: 16) {
                Spacer()
                
                // App Icon / Logo
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 120, height: 120)
                        .background(Material.ultraThinMaterial.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                    
                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                }
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .opacity(isAnimating ? 1.0 : 0.0)
                .shadow(color: .appPrimary.opacity(0.3), radius: 30, x: 0, y: 15)
                
                // App Name
                Text("Loki")
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y: isAnimating ? 0 : 20)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                // Subtitle
                Text("Dein digitaler Schulbegleiter")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.7))
                    .offset(y: isAnimating ? 0 : 15)
                    .opacity(isAnimating ? 0.8 : 0.0)
                
                Spacer()
                
                // Loading indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            // Animate entrance
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.1)) {
                isAnimating = true
            }
            
            // Transition to login after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    onFinished()
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SplashScreenView(onFinished: {})
}
