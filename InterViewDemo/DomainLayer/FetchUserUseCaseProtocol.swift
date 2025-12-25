import Foundation

protocol FetchUserUseCaseProtocol {
    func execute() async throws -> [User]
}
