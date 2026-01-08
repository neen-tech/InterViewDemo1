import Foundation
import XCTest
@testable import InterViewDemo

class MockUserRepository: UserRepositoryProtocol {
   
    var shouldUserCalled: Bool = false
    var shouldThoughError: Bool = false
    var usersToReturn: [User] = []
    
    @MainActor
    func fetchUsers() async throws -> [User] {
        if shouldThoughError {
            throw ApiError.serverError(500)
        }
        return usersToReturn
    }
    
}
