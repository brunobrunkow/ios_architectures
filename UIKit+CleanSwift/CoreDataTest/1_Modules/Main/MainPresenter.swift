import UIKit

protocol MainPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: MainViewModel)
}

final class MainPresenter {

    private(set) unowned var output: MainPresenterOutput
    private(set) var router: MainRouterProtocol
    private var viewModel: MainViewModel?

    // MARK: - Initializers

    init(output: MainPresenterOutput, router: MainRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = self.viewModel ?? MainViewModel()

        update(with: viewModel)
    }

    func presentAddModule() {
        router.presentAddModule()
    }

    func update(with viewModel: MainViewModel) {
        guard self.viewModel != viewModel else { return }
        
        self.viewModel = viewModel
        output.update(with: viewModel)
    }
}
