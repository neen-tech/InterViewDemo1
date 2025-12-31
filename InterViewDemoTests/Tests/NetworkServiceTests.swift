import Foundation
import XCTest
@testable import InterViewDemo

@MainActor
class NetworkServiceTests: XCTestCase {
    
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
    
    func test_with_success_result() async throws {
        let expectedUsers = mockNetworkService.mockUsers
        mockNetworkService.shouldFailure = false
        
        // Act
        let users = try await sut.fetchUsers()
        // Assert
        XCTAssertEqual(users.count, expectedUsers.count)
        XCTAssertEqual(users.first?.name, "Leanne Graham")
        XCTAssertEqual(users.last?.username, "Antonette")
    }
    
    
    func test_ServerError() async throws {
        mockNetworkService.shouldFailure =  true
        
        do {
            let _:[User] = try await sut.fetchUsers()
            XCTFail("Expected error but got nil")
        } catch let error as ApiError {
            switch error {
            case .serverError(let code):
                XCTAssertEqual(code, 500, "server code 500 interal server issue")
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected Error\(error.localizedDescription)")
        }
    }
    
    func test_invaild_EndPoint() async throws {
        do {
            let _:[User] = try await mockNetworkService.fetchData(endpoint: "/invaild")
            XCTFail("Invaild URL error")
        } catch let error as ApiError {
            XCTAssertEqual(error, .invalidURL)
        }catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_Decoding_Error() async throws {
       // mockNetworkService.shouldFailure =  true
        do {
            let _: String = try await mockNetworkService.fetchData(endpoint: "/users")
            XCTFail("Decoding error")
        }
        catch let error as ApiError {
            XCTAssertEqual(error, .decodeError)
        }catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
}
