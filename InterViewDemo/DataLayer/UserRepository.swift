import Foundation

class UserRepository:UserRepositoryProtocol {
   private let networkService:NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUsers() async throws -> [User] {
        guard let urlUser = EndPoint.users.url else {
            throw ApiError.invalidURL
        }
        return try await networkService.fetchData(endpoint:urlUser)
    }
}
