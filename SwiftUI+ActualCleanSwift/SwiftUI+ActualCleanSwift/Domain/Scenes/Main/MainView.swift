import SwiftUI

protocol MainDisplayLogic {
    
    func displayEmployees(viewModel: Main.LoadEmployees.ViewModel)
}

struct MainView: View {
    
    var interactor: MainBusinessLogic?
    
    @ObservedObject var employees = EmployeeDataStore()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(employees.displayedEmployees, id: \.id) { employee in
                        Text(employee.name)
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            deleteEmployee(id: employees.displayedEmployees[index].id)
                        }
                    })
                }
            }
        }
        .navigationTitle("Employees")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("Clear") {
                    // TODO clear
//                    viewStore.send(.clearButtonTapped)
                }
                .tint(Color.black)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    // TODO Add
//                    viewStore.send(.plusButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }
                .tint(Color.black)
            }
        }
        .onAppear {
            fetchEmployees()
        }
    }
    
    func fetchEmployees() {
        let request = Main.LoadEmployees.Request()
        interactor?.loadEmployees(request: request)
    }
    
    func deleteEmployee(id: String) {
        let request = Main.DeleteEmployee.Request(id: id)
        interactor?.deleteEmployee(id: request)
    }
}

extension MainView: MainDisplayLogic {
    
    func displayEmployees(viewModel: Main.LoadEmployees.ViewModel) {
        employees.displayedEmployees = viewModel.displayedEmployees
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
