import Foundation

struct Employee: Equatable, Identifiable, Decodable {

    var id: Int
    var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(_ employee: CoreEmployee) {
        name = employee.username ?? ""
        id = Int(employee.number)
    }
}
