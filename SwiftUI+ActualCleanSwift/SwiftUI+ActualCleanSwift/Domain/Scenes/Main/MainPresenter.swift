import Foundation

protocol MainPresentationLogic {

    func presentEmployees(response: Main.LoadEmployees.Response)
}

class MainPresenter {

    var view: MainDisplayLogic?
}

extension MainPresenter: MainPresentationLogic {

    func presentEmployees(response: Main.LoadEmployees.Response) {
        let viewModel = Main
            .LoadEmployees
            .ViewModel(displayedEmployees: response.employees.map {
                Main
                    .DisplayedEmployee(
                        id: String($0.id),
                        name: $0.name
                    )
            })
        view?.displayEmployees(viewModel: viewModel)
    }
    
    func presentEmployees(response: Main.DeleteEmployee.Response) {
        
    }
    
    private func presentEmployees(_ employees: [Employee]) {
        
    }
}
