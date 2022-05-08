import UIKit

protocol AddPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: AddViewModel)
}

final class AddPresenter {

    private(set) unowned var output: AddPresenterOutput
    private(set) var router: AddRouterProtocol
    private var viewModel: AddViewModel?

    // MARK: - Initializers

    init(output: AddPresenterOutput, router: AddRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - AddInteractorOutput

extension AddPresenter: AddInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = self.viewModel ?? AddViewModel()

        update(with: viewModel)
    }

    func update(with viewModel: AddViewModel) {
        guard self.viewModel != viewModel else { return }
        
        self.viewModel = viewModel
        output.update(with: viewModel)
    }

    func dismissView(completion: @escaping () -> Void) {
        router.dismissView(completion: completion)
    }
}
