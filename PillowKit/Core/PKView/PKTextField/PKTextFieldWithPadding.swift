import UIKit

class PKTextFieldWithPadding: UITextField {
    private let padding = UIEdgeInsets(
        top: 0,
        left: 5,
        bottom: 0,
        right: 5
    )
}

extension PKTextFieldWithPadding {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
