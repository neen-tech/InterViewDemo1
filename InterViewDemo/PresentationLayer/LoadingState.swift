import Foundation

enum LoadingState:Equatable {
    case idle
    case loading
    case loaded([User])
    case error(String)
}
