import UIKit

protocol MainViewControllerOutput {

    /// The `MainViewController`'s view finished loading.
    func viewLoaded()

    func userDidPressAdd()

    func userDidPressClear()

    func userDidPressDelete(for employeeNumber: Int)
}

final class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?

    private var employees: [Employee] = []

    // MARK: - Inputs and Outputs

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: MainViewControllerOutput!

    // MARK: - Initializers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        MainConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        output.viewLoaded()
    }

    private func setupTableView() {
        tableView?.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
    }

    private func setupNavigationBar() {
        title = "Employees"
        navigationItem.rightBarButtonItem = .init(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(add)
        )
        navigationItem.leftBarButtonItem = .init(
            title: "Clear",
            style: .plain,
            target: self,
            action: #selector(clear)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc
    private func add() {
        output.userDidPressAdd()
    }

    @objc
    private func clear() {
        output.userDidPressClear()
    }
}

// MARK: - MainPresenterOutput

extension MainViewController: MainPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: MainViewModel) {
        self.employees = viewModel.employees
        update(with: viewModel.l10n)
        update(with: viewModel.accessibilityData)
        tableView?.reloadData()
    }
    
    private func update(with accessibilityData: MainAccessibilityData) {}

    private func update(with l10n: MainL10n) {}
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { employees.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }

        let employee = employees[indexPath.item]
        cell.update(with: .init(name: employee.name, employeeNumber: String(employee.number)))

        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let employeeNumber = employees[indexPath.item].number
        output.userDidPressDelete(for: employeeNumber)
    }
}
