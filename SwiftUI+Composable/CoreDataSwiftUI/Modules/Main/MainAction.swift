import Foundation

enum MainAction: Equatable {

    case onAppear
    case plusButtonTapped
    case addViewDismissed
    case clearButtonTapped
    case deleteEmployee(_ employee: Employee)
    case employeeResult(Result<[Employee], Never>)
}
