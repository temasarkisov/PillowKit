import UIKit

final class PKViewBuilder {
    func build(viewRules: PKViewRules) -> UIView {
        let view = build(viewType: viewRules.viewType)
        
        print(viewRules.visualProperties)
        view.apply(visualProperties: viewRules.visualProperties)
        
        return view
    }
}

extension PKViewBuilder {
    private func build(viewType: PKViewRules.ViewType) -> UIView {
        switch viewType {
        case .view:
            return PKView()
        case .imageView:
            return PKImageView()
        case .textField:
            return PKTextField()
        case .unknown:
            return PKView()
        }
    }
}
