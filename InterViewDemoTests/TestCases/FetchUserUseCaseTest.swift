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
        //Given
        
        guard let url = Bundle(for: FetchUserUseCaseTest.self).url(forResource: "MockData", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            throw ApiError.noData
        }
        do {
            let userExpected:[User] = try JSONDecoder().decode([User].self, from: data)
            mockUserRepository.usersToReturn = userExpected
        } catch {
            throw ApiError.decodeError
        }
        
        
        //When
        let user = try await sut.execute()
        //Then
        XCTAssertEqual(user.count, 2)
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
