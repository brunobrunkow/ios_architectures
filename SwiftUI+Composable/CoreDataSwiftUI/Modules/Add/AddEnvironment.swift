import ComposableArchitecture

struct AddEnvironment {

    var storeEmployee: (Employee) -> Effect<Void, NSError>

    private static var employeeService = EmployeeService()
}

extension AddEnvironment {

    static let live: AddEnvironment = .init(
        storeEmployee: { employee in
            Self
                .employeeService
                .storeEmployee(employee: employee)
                .setFailureType(to: NSError.self)
                .eraseToEffect()
        }
    )
}
