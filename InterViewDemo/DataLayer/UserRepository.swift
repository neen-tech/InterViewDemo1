import Foundation

class UserRepository:UserRepositoryProtocol {
    let networkService:NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUsers() async throws -> [User] {
        return try await networkService.fetchData(endpoint: "/users")
    }
}
