import Foundation
import SwiftUI

@Observable @MainActor
final class UserListViewModel: UserListViewModelProtocol {
    
    
    var users:[User] = []
    var isLoading: Bool = false
    var errorMassage: String? = nil
    
    let fetchUserRepostiory: FetchUserUseCaseProtocol
    
    init(fetchUserRepostiory: FetchUserUseCaseProtocol) {
        self.fetchUserRepostiory = fetchUserRepostiory
    }
    
    func loadUsers() async {
        isLoading = true
        errorMassage = nil
        do {
            self.users = try await self.fetchUserRepostiory.execute()
        } catch {
            errorMassage = "Unable to load Users"
        }
        isLoading = false
    }
}
