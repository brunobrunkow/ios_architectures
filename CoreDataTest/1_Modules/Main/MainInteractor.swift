import UIKit

protocol MainInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied.
    func update(with viewModel: MainViewModel)

    func presentAddModule()
}

final class MainInteractor {

    private let output: MainInteractorOutput
    private let worker: MainWorkerInput

    // MARK: - Initializers

    init(
        output: MainInteractorOutput,
        worker: MainWorkerInput = MainWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - MainViewControllerOutput

extension MainInteractor: MainViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        worker.fetchEmployees()
    }
    
    func userDidPressAdd() {
        output.presentAddModule()
    }

    func userDidPressClear() {
        worker.clear()
    }

    func userDidPressDelete(for employeeNumber: Int) {
        worker.deleteEmployee(number: employeeNumber)
    }
}

// MARK: - MainWorkerOutput

extension MainInteractor: MainWorkerOutput {

    func didFetchEmployees(_ employees: [Employee]) {
        output.update(with: .init(employees: employees))
    }
}

// MARK: - AddDelegate

extension MainInteractor: AddDelegate {

    func didStoreEmployee() {
        worker.fetchEmployees()
    }
}
