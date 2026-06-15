import SwiftUI

@main
struct AndreuTVApp: App {
    @StateObject var viewModel = IPTVViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: IPTVViewModel
    
    var body: some View {
        if viewModel.isLoggedIn {
            DashboardView()
        } else {
            LoginView()
        }
    }
}
