import UIKit

public protocol NibLoadable: AnyObject {

    static var nib: UINib { get }

    func setupAppearance()
}

extension NibLoadable {

    public static var nib: UINib {
        UINib(
            nibName: String(describing: self),
            bundle: Bundle(for: self)
        )
    }

    public func setupAppearance() {
        // default implementation doesn't do anything
    }
}

extension NibLoadable where Self: UIView {
    
    public func loadFromNib() {
        guard let subview = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            assertionFailure("Could not instantiate '\(Self.nib)' for instance '\(self)'")
            return
        }
        addSubview(subview)
        subview.fitInSuperview()
        setupAppearance()
    }
}
