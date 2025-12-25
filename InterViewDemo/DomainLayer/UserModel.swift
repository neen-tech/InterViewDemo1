import Foundation

struct User: Codable,
                  Identifiable,
                  Equatable,Hashable {
    let id : Int
    let name : String
    let email : String
    let username : String
}

