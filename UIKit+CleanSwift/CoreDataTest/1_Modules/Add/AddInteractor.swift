import UIKit

protocol AddDelegate: AnyObject {

    func didStoreEmployee()
}

protocol AddInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied.
    func update(with viewModel: AddViewModel)

    func dismissView(completion: @escaping () -> Void)
}

final class AddInteractor {

    private let output: AddInteractorOutput
    private let worker: AddWorkerInput

    weak var delegate: AddDelegate?

    // MARK: - Initializers

    init(
        output: AddInteractorOutput,
        worker: AddWorkerInput = AddWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - AddViewControllerOutput

extension AddInteractor: AddViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func userdidPressAdd(username: String, employeeNumber: Int) {
        worker.storeEmployee(employee: .init(name: username, number: employeeNumber))
    }
}

// MARK: - AddWorkerOutput

extension AddInteractor: AddWorkerOutput {

    func didStoreEmployee() {
        output.dismissView { [weak delegate] in
            delegate?.didStoreEmployee()
        }
    }
}

