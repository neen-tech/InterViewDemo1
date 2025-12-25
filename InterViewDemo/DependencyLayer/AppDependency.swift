import Foundation

class AppDependency {
    
    let networkService: NetworkServiceProtocol
    let userRepositroy: UserRepositoryProtocol
    let fecthUserUseCase: FetchUserUseCaseProtocol
    
    init(networkService: NetworkServiceProtocol? = nil, userRepositroy: UserRepositoryProtocol? = nil, fecthUserUseCase: FetchUserUseCaseProtocol? = nil) {
        self.networkService = networkService ?? NetworkService()
        self.userRepositroy = UserRepository(networkService: self.networkService)
        self.fecthUserUseCase = FetchUserUseCase(userRepository: self.userRepositroy)
    }
    
    func makeVM() -> UserListViewModel {
        return UserListViewModel(fetchUserRepostiory: self.fecthUserUseCase)
    }
}
