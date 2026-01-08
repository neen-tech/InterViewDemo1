import Foundation

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T:Decodable>(endpoint: URL) async throws -> T  {
        let (data, response) = try await session.data(from: endpoint)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.noData }
        guard (200...299).contains(httpResponse.statusCode) else { throw ApiError.serverError(httpResponse.statusCode) }
        do {
            let decorder = try JSONDecoder().decode(T.self, from: data)
            return decorder
        } catch {
            throw ApiError.decodeError
        }
    }
}
