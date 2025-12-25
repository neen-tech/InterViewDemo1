import XCTest
import Foundation
@testable import InterViewDemo

class MockFetchUserUseCase: FetchUserUseCaseProtocol {
    var shouldThoughError: Bool = false
    var usersToReturn: [User] = []
    
    @MainActor
    func execute() async throws -> [User] {
        if shouldThoughError {
           throw ApiError.serverError(500)
        }
        return usersToReturn
    }
}
