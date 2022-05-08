import Combine
import Foundation

protocol MainBusinessLogic {

    func loadEmployees(request: Main.LoadEmployees.Request)
    func deleteEmployee(request: Main.DeleteEmployee.Request)
}

class MainInteractor {

    var presenter: MainPresentationLogic?

    private let employeeService: EmployeeService

    private var subscribers = Set<AnyCancellable>()

    init() {
        employeeService = EmployeeService()
    }
}

extension MainInteractor: MainBusinessLogic {

    func loadEmployees(request: Main.LoadEmployees.Request) {
        employeeService
            .fetchAllEmployees()
            .receive(on: DispatchQueue.main)
            .sink { employees in
                guard let employees = employees else { return }

                let response = Main.LoadEmployees.Response(employees: employees)
                self.presenter?.presentEmployees(response: response)
            }
            .store(in: &subscribers)
    }
    
    func deleteEmployee(request: Main.DeleteEmployee.Request) {
        guard let employeeId = Int(request.id) else {
            return
        }
        employeeService
            .deleteEmployee(number: employeeId)
            .flatMap { self.employeeService.fetchAllEmployees() }
            .receive(on: DispatchQueue.main)
            .sink { employees in
                guard let employees = employees else { return }

                let response = Main.DeleteEmployee.Response(employees: employees)
                self.presenter?.presentEmployees(response: response)
            }
            .store(in: &subscribers)
    }
}
