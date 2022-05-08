import UIKit

final class UserCell: UITableViewCell, LoadableIdentifiable {

    @IBOutlet private weak var username: UILabel?
    @IBOutlet private weak var employeeNumber: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupAppearance()
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: UserCellViewModel) {
        username?.text = viewModel.name
        employeeNumber?.text = viewModel.employeeNumber
    }
}
