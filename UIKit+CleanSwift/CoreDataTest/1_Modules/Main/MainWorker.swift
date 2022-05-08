import Combine
import UIKit

protocol MainWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: MainWorkerOutput! { get set }

    func fetchEmployees()

    func deleteEmployee(number: Int)

    func clear()
}

protocol MainWorkerOutput: AnyObject {

    func didFetchEmployees(_ employees: [Employee])
}

class MainWorker: MainWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: MainWorkerOutput!

    private var employeeService: EmployeeService

    private var subscribers = Set<AnyCancellable>()

    // MARK: - Initializers

    init(
        output: MainWorkerOutput? = nil,
        employeeService: EmployeeService = EmployeeService()
    ) {
        self.output = output
        self.employeeService = employeeService
    }

    func fetchEmployees() {
        employeeService
            .fetchAllEmployees()
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] employees in
                self?.output.didFetchEmployees(employees.sorted(by: { $0.number < $1.number }))
            }
            .store(in: &subscribers)
    }

    func deleteEmployee(number: Int) {
        employeeService
            .deleteEmployee(number: number)
            .sink { [weak self] _ in
                self?.fetchEmployees()
            }
            .store(in: &subscribers)
    }

    func clear() {
        employeeService
            .clear()
            .sink { [weak self] _ in
                self?.fetchEmployees()
            }
            .store(in: &subscribers)
    }
}
