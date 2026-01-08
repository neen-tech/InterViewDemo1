import Foundation
import XCTest
@testable import InterViewDemo

@MainActor
class NetworkServiceTests: XCTestCase {
    var networkService:NetworkService!
    var session : URLSession!
    
    override func setUp()  {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        networkService = NetworkService(session: session)
    }
    
    func test_case_fetch_user_successfully() async throws {
        //Given
        guard let url = Bundle(for: NetworkServiceTests.self).url(forResource: "MockData",
                                                                  withExtension: "json"),
        let data = try? Data(contentsOf: url) else  {
            throw ApiError.noData
        }
        MockURLProtocol.mockData = data
        MockURLProtocol.mockError = nil
        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        
        let testURL = URL(string: "https://test.com")!
        let users:[User] = try await networkService.fetchData(endpoint: testURL)
        
        //Then
        
        XCTAssertEqual(users.count, 2, "User count will be 2")
        XCTAssertEqual(users.first?.name, "Leanne Graham")
        
        
    }
    
    
    func test_case_for_invalid_response() async throws {
        //Given

        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                                       statusCode: 500,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockError = nil
        //When
        
        do {
            let url = URL(string: "https://test.com")!
            let _: [User] = try await networkService.fetchData(endpoint: url)
            XCTFail("Expeected Decode Error")
        } catch let error {
            XCTAssertTrue(error is ApiError)
        }
    }
    
    func test_case_decoding_error() async throws {
        //Given
        let json = "{invalid json}"
        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockData = json.data(using: .utf8)
        
        
        //When
        
        do {
            let url  = URL(string: "https://test.com")!
            let _:[User] = try await networkService.fetchData(endpoint: url)
            XCTFail("expected as decoding fail")
        } catch let error {
            XCTAssertEqual(error as? ApiError, ApiError.serverError(500))
        }
        
    }
    
}
