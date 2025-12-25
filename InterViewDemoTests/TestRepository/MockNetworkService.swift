import XCTest
@testable import InterViewDemo

class MockNetworkService: NetworkServiceProtocol {
     var shouldFailure: Bool = false
     var mockUsers:[User] = [User(id: 1, name: "Leanne Graham", email: "Sincere@april.biz", username: "Bret"), User(id: 2, name: "Ervin Howell", email: "Shanna@melissa.tv", username: "Antonette")]
    
    func fetchData<T>(endpoint: String) async throws -> T {
        if shouldFailure {
            throw ApiError.serverError(500)
        }
        
        try await Task.sleep(nanoseconds:100_000_000)
        if endpoint.contains("/users") {
            guard let users = mockUsers as? T  else { throw ApiError.decodeError }
            return users
        }
        
        throw ApiError.invalidURL
    }
     
}
