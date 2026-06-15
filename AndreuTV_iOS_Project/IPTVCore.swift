import Foundation

struct IPTVServer {
    var url: String = "http://andreutv.xyz/"
    var username: String = ""
    var password: String = ""
    
    var loginURL: URL? {
        URL(string: "\(url)player_api.php?username=\(username)&password=\(password)")
    }
}

class IPTVViewModel: ObservableObject {
    @Published var categories: [IPTVCategory] = []
    @Published var streams: [IPTVStream] = []
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var server = IPTVServer()
    
    func login(user: String, pass: String) {
        isLoading = true
        errorMessage = nil
        
        server.username = user
        server.password = pass
        
        guard let url = server.loginURL else {
            self.errorMessage = "Invalid Server URL"
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No response from server"
                    return
                }
                
                do {
                    // El formato de Xtream Codes devuelve un objeto "user_info" si el login es exitoso
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let userInfo = json?["user_info"] as? [String: Any], 
                       let auth = userInfo["auth"] as? Int, auth == 1 {
                        self.isLoggedIn = true
                        self.fetchCategories()
                    } else {
                        self.errorMessage = "Invalid Credentials"
                    }
                } catch {
                    self.errorMessage = "Parsing Error"
                }
            }
        }.resume()
    }
    
    func fetchCategories() {
        let catURL = "\(server.url)player_api.php?username=\(server.username)&password=\(server.password)&action=get_live_categories"
        guard let url = URL(string: catURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([IPTVCategory].self, from: data) {
                    DispatchQueue.main.async {
                        self.categories = decoded
                    }
                }
            }
        }.resume()
    }
}

struct IPTVCategory: Identifiable, Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "category_id"
        case name = "category_name"
    }
}

struct IPTVStream: Identifiable, Codable {
    let id: Int
    let name: String
    let streamID: Int
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case name = "name"
        case streamID = "stream_id"
        case icon = "stream_icon"
    }
}
