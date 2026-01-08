import XCTest
@testable import InterViewDemo

class MockNetworkService: NetworkServiceProtocol {
     var shouldFailure: Bool = false
    func fetchData<T:Decodable>(endpoint: URL) async throws -> T {
        if shouldFailure {
            throw ApiError.serverError(500)
        }
        
        guard let urlLocal  = Bundle(for: MockNetworkService.self).url(forResource: "MockData",
                                                                       withExtension: "json"),
                let data = try? Data(contentsOf: urlLocal) else {
            throw ApiError.noData
        }
        do {
            let decoder = try JSONDecoder().decode(T.self, from: data)
            return decoder
        } catch {
            throw ApiError.decodeError
        }
        
    }
     
}
