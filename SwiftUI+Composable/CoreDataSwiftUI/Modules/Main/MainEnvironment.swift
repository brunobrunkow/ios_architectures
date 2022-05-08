import Combine
import ComposableArchitecture

struct MainEnvironment {

    var mainQueue: AnySchedulerOf<DispatchQueue>
    var clearEmployees: () -> Effect<Void, Never>
    var fetchEmployees: () -> Effect<[Employee], Never>
    var deleteEmployee: (Int) -> Effect<Void, Never>

    private static var employeeService = EmployeeService()
}

extension MainEnvironment {

    static let preview = Self(
        mainQueue: .main,
        clearEmployees: { Effect<Void, Never>(value: ()) },
        fetchEmployees: {
            Effect(value: .mocks(count: 10))
                .delay(for: 3, scheduler: DispatchQueue.main)
                .eraseToEffect()
        },
        deleteEmployee: { _ in Effect<Void, Never>(value: ()) }
    )
    static let live = Self(
        mainQueue: .main,
        clearEmployees: {
            Self.employeeService
                .clear()
                .eraseToEffect()
        },
        fetchEmployees: {
            Self.employeeService
                .fetchAllEmployees()
                .compactMap { $0 }
                .eraseToEffect()
        },
        deleteEmployee: { employeeNumber in
            Self.employeeService
                .deleteEmployee(number: employeeNumber)
                .eraseToEffect()
        }
    )
}
