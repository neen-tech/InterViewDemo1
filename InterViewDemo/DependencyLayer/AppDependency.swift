import Foundation

class AppDependency {
    
    let networkService: NetworkServiceProtocol
    let userRepositroy: UserRepositoryProtocol
    let fetchUserUseCase: FetchUserUseCaseProtocol
    
    init(networkService: NetworkServiceProtocol, userRepositroy: UserRepositoryProtocol, fecthUserUseCase: FetchUserUseCaseProtocol) {
        self.networkService = networkService
        self.userRepositroy = userRepositroy
        self.fetchUserUseCase = fecthUserUseCase
    }
    
    func makeVM() -> UserListViewModel {
        return UserListViewModel(fetchUserRepostiory: self.fetchUserUseCase)
    }
}
