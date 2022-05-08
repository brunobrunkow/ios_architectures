import Foundation

struct Employee {
    
    var id: Int
    var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init?(_ coreEmployee: CoreEmployee) {
        guard let name = coreEmployee.username else { return nil }

        self.id = Int(coreEmployee.number)
        self.name = name
    }
}
