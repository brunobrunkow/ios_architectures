import Foundation

struct Employee: Equatable {
    let name: String
    let number: Int

    init(_ employee: CoreEmployee) {
        name = employee.username ?? ""
        number = Int(employee.number)
    }

    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}
