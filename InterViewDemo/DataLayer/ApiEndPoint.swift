import Foundation

enum EndPoint {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    case users
    
    var url:URL? {
        return URL(string: EndPoint.baseURL + self.path)
    }
    
    private var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
}
