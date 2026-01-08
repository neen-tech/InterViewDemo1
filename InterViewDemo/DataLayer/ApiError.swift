import Foundation

enum ApiError: Error, Equatable {
    case noData
    case invalidURL
    case decodeError
    case serverError(Int)
    case networkError(String)
}


