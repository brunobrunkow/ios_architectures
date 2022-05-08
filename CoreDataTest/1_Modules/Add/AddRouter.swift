import UIKit

protocol AddRouterProtocol: AnyObject {

    var viewController: AddViewController? { get }

    func dismissView(completion: @escaping () -> Void)
}

final class AddRouter {

    weak var viewController: AddViewController?

    // MARK: - Initializers

    init(viewController: AddViewController?) {
        self.viewController = viewController
    }
}

// MARK: - AddRouterProtocol

extension AddRouter: AddRouterProtocol {

    // MARK: - Navigation

    func dismissView(completion: @escaping () -> Void) {
        viewController?.parent?.dismiss(animated: true, completion: completion)
    }
}
