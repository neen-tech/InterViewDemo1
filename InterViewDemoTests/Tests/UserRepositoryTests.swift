import Foundation
import XCTest
@testable import InterViewDemo

@MainActor
class UserRepositoryTests: XCTestCase {
   
    var sut: UserRepository!
    var mockNetworkService: MockNetworkService!
    
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = UserRepository(networkService: mockNetworkService)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockNetworkService = nil
    }
   
   
    func test_if_user_is_fetched_successfully() async throws {
        mockNetworkService.shouldFailure = false
        let users = try await sut.fetchUsers()
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users.first?.name, "Leanne Graham")
    }
    
    func test_if_user_is_not_fetched_successfully() async throws {
        mockNetworkService.shouldFailure = true
        do {
            _ = try await sut.fetchUsers()
            XCTFail("Service calling issue going on")
        } catch let error as ApiError {
            XCTAssertEqual(error, ApiError.serverError(500))
        }
    }
    
    
}
