import SwiftUI

struct DashboardView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo original extraído
                Image("default_bg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("home_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .padding(.top, 20)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        DashboardButton(title: "LIVE TV", icon: "ic_ShadeeD_dash_tv", color: .orange)
                        DashboardButton(title: "MOVIES", icon: "ic_ShadeeD_dash_movie", color: .blue)
                        DashboardButton(title: "SERIES", icon: "ic_ShadeeD_dash_series", color: .green)
                        DashboardButton(title: "EPG", icon: "ic_ShadeeD_dash_playlist", color: .yellow)
                        DashboardButton(title: "ACCOUNT", icon: "ic_ShadeeD_dash_useraccount", color: .purple)
                        DashboardButton(title: "SETTINGS", icon: "ic_ShadeeD_dash_settings", color: .gray)
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Image("banner")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                    }
                    .padding(.bottom, 10)
                    
                    Text("Andreu TV v1.0 - iPhone Edition")
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct DashboardButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.bottom, 5)
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(gradient: Gradient(colors: [color.opacity(0.7), color.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
