import XCTest
import Foundation
@testable import InterViewDemo

class MockFetchUserUseCase: FetchUserUseCaseProtocol {
    var shouldThrowError: Bool = false
    var usersToReturn: [User] = []
    
    @MainActor
    func execute() async throws -> [User] {
        if shouldThrowError {
           throw ApiError.serverError(500)
        }
        return usersToReturn
    }
}
