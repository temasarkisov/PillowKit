import UIKit

final class PKViewBuilder {
    func build(viewRules: PKViewRules) -> UIView? {
        let view = build(viewType: viewRules.viewType)
        
        if let label = view as? PKLabel {
            label.apply(visualProperties: viewRules.visualProperties)
            return label
        }
        if let imageView = view as? PKImageView {
            imageView.apply(visualProperties: viewRules.visualProperties)
            return imageView
        }
        if let textField = view as? PKTextField {
            textField.apply(visualProperties: viewRules.visualProperties)
            return textField
        }
        if let button = view as? PKButton {
            button.apply(visualProperties: viewRules.visualProperties)
            button.apply(visualEffects: viewRules.visualEffects)
            return button
        }
        
        return nil
    }
}

extension PKViewBuilder {
    private func build(viewType: PKViewRules.ViewType) -> UIView? {
        switch viewType {
        case .label:
            return PKLabel()
        case .image:
            return PKImageView()
        case .textField:
            return PKTextField()
        case .button:
            return PKButton()
        case .unknown:
            return nil
        }
    }
}
