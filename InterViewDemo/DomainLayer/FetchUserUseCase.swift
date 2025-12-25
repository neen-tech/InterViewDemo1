import Foundation

class FetchUserUseCase: FetchUserUseCaseProtocol {
    let userRepository: UserRepositoryProtocol
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> [User] {
       return try await userRepository.fetchUsers()
    }
}
