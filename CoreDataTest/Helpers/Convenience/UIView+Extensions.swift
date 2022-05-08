import UIKit

/// A UIView extension to make a view the same size as the superview by
/// setting the appropriate constraints
public extension UIView {

    /// Fits the view into into the superview by setting the appropriate
    /// constraints. When calling the function with the default parameters `fitInSuperview()`
    /// the view gets the same size as it's superview, with constraints to all
    /// edges.
    ///
    /// If any of the **inset parameters** is **nil**, the matching edge
    /// does not get any constraint!
    ///
    /// If any of the **inset parameters** is **negative**, then the subview
    /// is exceeding the superview. Depending on the superview's clipping behavior
    /// it may show beyond its borders
    ///
    /// If **widthToHeightRatio** is given, a ratio constraint is set.
    /// In this case, one of the other parameters should be nil, otherwise the
    /// view becomes overconstrained and will produce layout errors.
    ///
    /// - Parameter top: the inset to use for the top constraint
    /// - Parameter leading: the inset to use for the top constraint
    /// - Parameter trailing: the inset to use for the top constraint
    /// - Parameter bottom: the inset to use for the bottom constraint.
    /// - Parameter excluding: the attributes of the edges to ignore. Allowed values: top, leading, trailing, bottom
    /// /// - Parameter widthToHeightRatio: the width to height ratio
    /// **default: nil**
    func fitInSuperview(
        top: CGFloat? = 0,
        leading: CGFloat? = 0,
        trailing: CGFloat? = 0,
        bottom: CGFloat? = 0,
        widthToHeightRatio: CGFloat? = nil,
        excluding excludedEdges: [NSLayoutConstraint.Attribute] = []
    ) {
        guard superview != nil else { return }

        translatesAutoresizingMaskIntoConstraints = false
        removeConstraintsToSuperview()

        if let top = top, !excludedEdges.contains(.top) {
            addConstraintToSuperview(
                attribute: .top,
                constant: top
            )
        }

        if let bottom = bottom, !excludedEdges.contains(.bottom) {
            addConstraintToSuperview(
                attribute: .bottom,
                constant: -bottom
            )
        }

        if let leading = leading, !excludedEdges.contains(.leading) {
            addConstraintToSuperview(
                attribute: .leading,
                constant: -leading
            )
        }

        if let trailing = trailing, !excludedEdges.contains(.trailing) {
            addConstraintToSuperview(
                attribute: .trailing,
                constant: trailing
            )
        }

        if let widthToHeightRatio = widthToHeightRatio {
            widthAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: widthToHeightRatio
            ).isActive = true
        }
    }

    private func addConstraintToSuperview(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        guard let superview = self.superview else { return }

        NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: superview,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        ).isActive = true
    }

    /// Remove all the constraints of self that are directly linked to the superview
    private func removeConstraintsToSuperview() {
        guard let superview = self.superview else { return }

        for constraint in self.constraints {
            let items = [constraint.firstItem, constraint.secondItem]
            for item in items {
                if let view = item as? UIView, view == superview {
                    self.removeConstraint(constraint)
                }
            }
        }
    }
}
