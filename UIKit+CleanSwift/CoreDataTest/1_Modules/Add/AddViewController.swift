import UIKit

protocol AddViewControllerOutput {

    var delegate: AddDelegate? { get set }

    /// The `AddViewController`'s view finished loading.
    func viewLoaded()

    func userdidPressAdd(username: String, employeeNumber: Int)
}

final class AddViewController: UIViewController {

    @IBOutlet private weak var userNameTextField: UITextField?
    @IBOutlet private weak var employeeNumberTextField: UITextField?
    @IBOutlet private weak var addButton: UIButton?

    // MARK: - Inputs and Outputs

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AddViewControllerOutput!

    // MARK: - Initializers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        AddConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
        title = "Add new user"
    }

    @IBAction private func didPressAddButton(_ sender: UIButton) {
        guard let username = userNameTextField?.text,
        let employeeNumberString = employeeNumberTextField?.text,
        let employeeNumber = Int(employeeNumberString) else {
            return assertionFailure("Unable to fetch values")
        }

        output.userdidPressAdd(username: username, employeeNumber: employeeNumber)
    }
}

// MARK: - AddPresenterOutput

extension AddViewController: AddPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: AddViewModel) {
        update(with: viewModel.l10n)
        update(with: viewModel.accessibilityData)
    }
    
    private func update(with accessibilityData: AddAccessibilityData) {}

    private func update(with l10n: AddL10n) {}
}
