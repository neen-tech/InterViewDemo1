import Foundation
import XCTest
@testable import InterViewDemo

class FetchUserUseCaseTest: XCTestCase {
    
    var sut: FetchUserUseCase!
    var mockUserRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockUserRepository = MockUserRepository()
        sut = FetchUserUseCase(userRepository: mockUserRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        mockUserRepository = nil
    }
    
    @MainActor
    func test_fetchUsers_for_success_result() async throws {
        let userExpected = [User(id: 1, name: "Leanne Graham", email: "Sincere@april.biz", username: "Bret")]
        mockUserRepository.usersToReturn = userExpected
        let user = try await sut.execute()
        XCTAssertEqual(user, userExpected)
        XCTAssertEqual(user.first?.name, "Leanne Graham")
    }
}
