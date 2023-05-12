import UIKit

final class PKViewBuilder {
    func build(viewRules: PKViewRules) -> UIView {
        let view = build(viewType: viewRules.viewType)
        
        view.apply(visualProperties: viewRules.visualProperties)
        
        return view
    }
}

extension PKViewBuilder {
    private func build(viewType: PKViewRules.ViewType) -> UIView {
        switch viewType {
        case .view:
            return UIView()
        case .imageView:
            return UIImageView()
        case .textField:
            return UITextField()
        case .unknown:
            return UIView()
        }
    }
}

extension UIView {
    fileprivate func apply(
        visualProperties: [PKViewRules.VisualPropertyKey: String]
    ) {
        guard let color = visualProperties[.backgroundColor] else {
            backgroundColor = .systemYellow
        }
        backgroundColor = UIColor(hex: color)
    }
}
