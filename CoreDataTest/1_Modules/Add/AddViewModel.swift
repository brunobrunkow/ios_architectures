import UIKit

/// A container for accessibility related values
struct AddAccessibilityData: Equatable {}

/// A container for localisation related values.
struct AddL10n: Equatable {}

struct AddViewModel: Equatable {

    // MARK: - ViewModel
    
    // MARK: - Containers

    let accessibilityData: AddAccessibilityData
    let l10n: AddL10n

    init(
        accessibilityData: AddAccessibilityData = .init(),
        l10n: AddL10n = .init()
    ) {
        self.accessibilityData = accessibilityData
        self.l10n = l10n
    }
}
