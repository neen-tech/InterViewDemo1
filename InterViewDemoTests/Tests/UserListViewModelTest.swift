import Foundation
import XCTest
@testable import InterViewDemo

@MainActor
class UserListViewModelTest: XCTestCase {
    var sut: UserListViewModel!
    var mockFetchUserUseCase: MockFetchUserUseCase!
    
    override func setUp() {
        super.setUp()
        
        mockFetchUserUseCase = MockFetchUserUseCase()
        sut = UserListViewModel(fetchUserRepostiory: mockFetchUserUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        mockFetchUserUseCase = nil
    }
    
    func test_fetch_user_with_success() async throws {
        let userExpected = [User(id: 1, name: "Leanne Graham", email: "Sincere@april.biz", username: "Bret")]
        mockFetchUserUseCase.usersToReturn = userExpected
        
        await sut.loadUsers()
        
        XCTAssertEqual(sut.users, userExpected)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMassage)
        
    }
    
    func testLoadUsers_WhenFails_SetsErrorMessage() async {
            mockFetchUserUseCase.shouldThoughError = true
            await sut.loadUsers()
            XCTAssertTrue(sut.users.isEmpty)
            XCTAssertFalse(sut.isLoading)
            XCTAssertNotNil(sut.errorMassage)
        }
}
