import Foundation

final class AddConfigurator {

    static func configure(viewController: AddViewController) {
        let router = AddRouter(viewController: viewController)
        let presenter = AddPresenter(output: viewController, router: router)
        let interactor = AddInteractor(output: presenter)

        viewController.output = interactor
    }
}
