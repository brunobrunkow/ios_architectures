import ComposableArchitecture
import Foundation

var mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .init { state, action, environment in

    let fetchEmployees = environment
        .fetchEmployees()                   // Effect<[Employee], NSError>
        .catchToEffect()                    // Effect<Result<[Employee], NSError>, Never>
        .map(MainAction.employeeResult)     // Effect<MainAction, Never>

    switch action {
    case .onAppear:
        return fetchEmployees
    case .plusButtonTapped:
        state.presentAddView = true
        return .none
    case .addViewDismissed:
        state.presentAddView = false
        return fetchEmployees
    case .clearButtonTapped:
        return environment
            .clearEmployees()
            .catchToEffect()
            .map { _ in MainAction.onAppear }
    case .deleteEmployee(let employee):
        return environment
            .deleteEmployee(employee.id)
            .catchToEffect()
            .map { _ in MainAction.onAppear }
    case .employeeResult(let result):
        switch result {
        case .success(let employees): state.employees = employees
        case .failure: break
        }
        return .none
    }
}
