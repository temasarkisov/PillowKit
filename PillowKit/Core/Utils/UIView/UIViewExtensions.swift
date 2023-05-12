import UIKit

extension UIView {
    func apply(
        visualProperties: [PKViewRules.VisualPropertyKey: String]
    ) {
        if let color = visualProperties[.backgroundColor] {
            backgroundColor = UIColor(hex: color)
        } else {
            backgroundColor = .systemYellow
        }
    }
}
