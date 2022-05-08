import AppTrackingTransparency
import Combine
import UIKit

protocol AddWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AddWorkerOutput! { get set }

    func storeEmployee(employee: Employee)
}

protocol AddWorkerOutput: AnyObject {

    func didStoreEmployee()
}

class AddWorker: AddWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: AddWorkerOutput!

    private let employeeService: EmployeeService

    private let status = ATTrackingManager.trackingAuthorizationStatus

    private lazy var subscribers = Set<AnyCancellable>()

    // MARK: - Initializers

    init(
        output: AddWorkerOutput? = nil,
        employeeService: EmployeeService = EmployeeService()
    ) {
        self.output = output
        self.employeeService = employeeService
    }

    func storeEmployee(employee: Employee) {
        employeeService
            .storeEmployee(employee: employee)
            .sink { [weak self] _ in
                self?.output.didStoreEmployee()
            }
            .store(in: &subscribers)
    }
}
