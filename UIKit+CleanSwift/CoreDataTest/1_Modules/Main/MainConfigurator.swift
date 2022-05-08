import Foundation

final class MainConfigurator {

    static func configure(viewController: MainViewController) {
        let router = MainRouter(viewController: viewController)
        let presenter = MainPresenter(output: viewController, router: router)
        let interactor = MainInteractor(output: presenter)

        viewController.output = interactor
    }
}
