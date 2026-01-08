import Foundation
import SwiftUI

@Observable @MainActor
final class UserListViewModel: UserListViewModelProtocol {
        
    private(set) var users: [User] = []
    private(set) var loadingState: LoadingState = .idle
    private let fetchUserRepostiory: FetchUserUseCaseProtocol
    init(fetchUserRepostiory: FetchUserUseCaseProtocol) {
        self.fetchUserRepostiory = fetchUserRepostiory
    }
    
    func loadUsers() async {
        loadingState = .loading
        do {
            users = try await self.fetchUserRepostiory.execute()
            loadingState = .loaded(users)
        } catch {
            loadingState = .error("Unable to Load from the server please try later")
        }
    }
}

