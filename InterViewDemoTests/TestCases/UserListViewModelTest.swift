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
        
        guard let url = Bundle(for: UserListViewModelTest.self).url(forResource: "MockData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw ApiError.noData
        }
        
        let userExpected = try JSONDecoder().decode([User].self, from: data)
        mockFetchUserUseCase.usersToReturn = userExpected
        
        await sut.loadUsers()
        
        XCTAssertEqual(sut.users, userExpected)
        if case .loaded(let users) = sut.loadingState {
            XCTAssertEqual(users, userExpected)

        } else {
            XCTFail("Expected .loaded state, got \(sut.loadingState)")
        }
        
        
    }
    
    func test_case_user_get_fails() async {
            mockFetchUserUseCase.shouldThrowError = true
            await sut.loadUsers()
        
            XCTAssertTrue(mockFetchUserUseCase.usersToReturn.isEmpty)
        
            if case .error(let message) = sut.loadingState {
                XCTAssertEqual(message, "Unable to Load from the server please try later")
            } else {
                XCTFail("Expected .loaded state, got \(sut.loadingState)")
            }
            
    }
    
    func test_case_check_idle(){
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertEqual(sut.loadingState, .idle)
    }
}
