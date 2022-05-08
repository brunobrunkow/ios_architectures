import ComposableArchitecture

var addReducer: Reducer<AddState, AddAction, AddEnvironment> = .init { state, action, environment in

    switch action {
    case .addButtonTapped:
        guard let employeeNumber = Int(state.id),
              !state.name.isEmpty else {
            return .none
        }
        let employee = Employee(id: employeeNumber, name: state.name)
        return environment
            .storeEmployee(employee)            // Effect<Void, NSError>
            .catchToEffect()                    // Effect<Result<Void, NSError>, Never>
            .map { _ in AddAction.dismissView}  // Effect<AddAction, Never>
    case .nameChanged(let name):
        state.name = name
        return .none
    case .numberChanged(let number):
        state.id = number
        return .none
    case .dismissView:
        state.isPresented = false
        return .none
    }
}
