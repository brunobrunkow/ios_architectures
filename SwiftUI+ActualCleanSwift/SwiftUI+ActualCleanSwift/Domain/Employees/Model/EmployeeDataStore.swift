import Combine
import Foundation

class EmployeeDataStore: ObservableObject {

    @Published var displayedEmployees: [Main.DisplayedEmployee] = []
}
