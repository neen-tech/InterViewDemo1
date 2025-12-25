import Foundation

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let baseURL: String
    
    init(session: URLSession = .shared,
         baseURL: String = "https://jsonplaceholder.typicode.com") {
        self.session = session
        self.baseURL = baseURL
    }
    
    func fetchData<T:Decodable>(endpoint: String) async throws -> T  {
        guard let url = URL(string: baseURL + endpoint) else { throw ApiError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.noData }
        
        guard (200...299).contains(httpResponse.statusCode) else { throw ApiError.serverError(httpResponse.statusCode) }
        
        do {
            let decoder = try JSONDecoder().decode(T.self, from: data)
            return decoder
        } catch {
            throw ApiError.decodeError
        }
    }
}
