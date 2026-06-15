import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: IPTVViewModel
    
    var body: some View {
        ZStack {
            Image("default_bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("home_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 50)
                
                Image("banner_login")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                VStack(spacing: 15) {
                    HStack {
                        Image("username_icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        TextField("Username", text: $username)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.3)))
                    
                    HStack {
                        Image("password_icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.3)))
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    viewModel.login(user: username, pass: password)
                }) {
                    Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Spacer()
                
                Text("Powered by Andreu TV")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(IPTVViewModel())
    }
}
