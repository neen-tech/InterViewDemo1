import Foundation
import XCTest
@testable import InterViewDemo

@MainActor
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
    
   
    func test_fetchUsers_for_success_result() async throws {
        let userExpected = [User(id: 1, name: "Leanne Graham", email: "Sincere@april.biz", username: "Bret")]
        mockUserRepository.usersToReturn = userExpected
        let user = try await sut.execute()
        XCTAssertEqual(user, userExpected)
        XCTAssertEqual(user.first?.name, "Leanne Graham")
    }
    
    func test_fetchUsers_failure() async {
        mockUserRepository.shouldThoughError = true
        do { _ = try await sut.execute()
            XCTFail("Expected ApiError but got success")
        }catch let error as ApiError {
            XCTAssertEqual(error, .serverError(500))
        } catch { XCTFail("Unexpected error: \(error)") }
    }
}
