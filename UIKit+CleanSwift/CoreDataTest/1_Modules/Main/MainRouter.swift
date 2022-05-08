import UIKit

protocol MainRouterProtocol: AnyObject {

    var viewController: MainViewController? { get }

    func presentAddModule()
}

final class MainRouter {

    weak var viewController: MainViewController?

    // MARK: - Initializers

    init(viewController: MainViewController?) {
        self.viewController = viewController
    }
}

// MARK: - MainRouterProtocol

extension MainRouter: MainRouterProtocol {

    // MARK: - Navigation

    func presentAddModule() {
        let addController = StoryboardScene.Add.initialScene.instantiate()

        if let addViewController = addController.topViewController as? AddViewController {
            addViewController.output.delegate = viewController?.output as? AddDelegate
        }

        viewController?.present(addController, animated: true)
    }
}
