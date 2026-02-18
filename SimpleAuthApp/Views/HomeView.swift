import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @available(iOS 16.0, *)
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.95, green: 0.97, blue: 1.0), Color(red: 0.9, green: 0.94, blue: 1.0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                if #available(iOS 16.0, *) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue.gradient)
                } else {
                    // Fallback on earlier versions
                }
                
                Text("Home")
                    .font(.title.bold())
                
                Text("Product & subscription options coming soon.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            HomeView()
        }
    } else {
        // Fallback on earlier versions
    }
}
