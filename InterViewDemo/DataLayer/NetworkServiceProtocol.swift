import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(endpoint:URL) async throws -> T
}
