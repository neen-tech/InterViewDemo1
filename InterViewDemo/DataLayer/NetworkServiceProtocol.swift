import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(endpoint:String) async throws -> T
}
