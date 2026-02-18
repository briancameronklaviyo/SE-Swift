import SwiftUI

private enum LandingDestination: Hashable {
    case home
    case profile
}

@available(iOS 16.0, *)
struct LandingView: View {
    @EnvironmentObject var authService: AuthService
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.95, green: 0.97, blue: 1.0), Color(red: 0.9, green: 0.94, blue: 1.0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    if let user = authService.currentUser {
                        Text(user.name)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 100))
                            .foregroundStyle(.blue.gradient)
                        
                        VStack(spacing: 16) {
                            Button("Go to Home") {
                                path.append(LandingDestination.home)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                            .controlSize(.large)
                            .padding(.horizontal, 48)
                            
                            Button("Profile") {
                                path.append(LandingDestination.profile)
                            }
                            .foregroundStyle(.blue)
                        }
                        .padding(.top, 16)
                    }
                }
                .padding(.top, 60)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: LandingDestination.self) { destination in
                switch destination {
                case .home:
                    HomeView()
                case .profile:
                    UserInfoView(embeddedInNavigationStack: false)
                        .environmentObject(authService)
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        LandingView()
            .environmentObject(AuthService.shared)
    } else {
        EmptyView()
    }
}
