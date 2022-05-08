import UIKit

/// A container for accessibility related values
struct MainAccessibilityData: Equatable {}

/// A container for localisation related values.
struct MainL10n: Equatable {}

struct MainViewModel: Equatable {

    // MARK: - ViewModel

    let employees: [Employee]
    
    // MARK: - Containers

    let accessibilityData: MainAccessibilityData
    let l10n: MainL10n

    init(
        employees: [Employee] = [],
        accessibilityData: MainAccessibilityData = .init(),
        l10n: MainL10n = .init()
    ) {
        self.employees = employees
        self.accessibilityData = accessibilityData
        self.l10n = l10n
    }
}
