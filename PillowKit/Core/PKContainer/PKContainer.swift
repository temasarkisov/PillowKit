import UIKit

final class PKContainer: PKView {
    private var viewWrappers: [PKViewWrapper] = []
    private var viewsConstraints: [NSLayoutConstraint] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate(viewsConstraints)
    }
}

extension PKContainer {
    func addViewWrapper(viewWrapper: PKViewWrapper) {
        viewWrappers.append(viewWrapper)
        viewWrapper.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewWrapper.view)
    }
    
    func calculateConstraints() {
        viewWrappers.forEach { viewWrapper in
            viewWrapper.viewLayoutConfig.forEach { (anchorName, anchorConfig) in
                guard let constraint = makeConstraint(
                    view: viewWrapper.view,
                    anchorName: anchorName,
                    anchorConfig: anchorConfig
                ) else {
                    return
                }
                viewsConstraints.append(constraint)
            }
        }
    }
    
    private func makeConstraint(
        view: PKView,
        anchorName: PKViewRules.AnchorName,
        anchorConfig: [String: String]
    ) -> NSLayoutConstraint? {
        let viewIDEqualTo = anchorConfig["id"] ?? ""

        guard let viewEqualTo = obtainView(by: viewIDEqualTo) else {
            guard let constant = Double(anchorConfig["constant"] ?? "") else {
                return nil
            }
            
            switch anchorName {
            case .width:
                return view.widthAnchor.constraint(
                    equalToConstant: constant
                )
            case .height:
                return view.heightAnchor.constraint(
                    equalToConstant: constant
                )
            default:
                return nil
            }
        }

        guard let anchorNameEqualTo = PKViewRules.AnchorName(rawValue: anchorConfig["to"] ?? "") else {
            return nil
        }
        
        guard let constant = Double(anchorConfig["constant"] ?? "") else {
            return nil
        }
        
        switch anchorName {
        case .left:
            switch anchorNameEqualTo {
            case .left:
                return view.leftAnchor.constraint(
                    equalTo: viewEqualTo.leftAnchor,
                    constant: constant
                )
            case .right:
                return view.leftAnchor.constraint(
                    equalTo: viewEqualTo.rightAnchor,
                    constant: constant
                )
            default:
                return nil
            }
        case .top:
            switch anchorNameEqualTo {
            case .top:
                return view.topAnchor.constraint(
                    equalTo: viewEqualTo.topAnchor,
                    constant: constant
                )
            case .bottom:
                return view.topAnchor.constraint(
                    equalTo: viewEqualTo.bottomAnchor,
                    constant: constant
                )
            default:
                return nil
            }
        case .right:
            switch anchorNameEqualTo {
            case .left:
                return view.rightAnchor.constraint(
                    equalTo: viewEqualTo.leftAnchor,
                    constant: constant
                )
            case .right:
                return view.rightAnchor.constraint(
                    equalTo: viewEqualTo.rightAnchor,
                    constant: constant
                )
            default:
                return nil
            }
        case .bottom:
            switch anchorNameEqualTo {
            case .top:
                return view.bottomAnchor.constraint(
                    equalTo: viewEqualTo.topAnchor,
                    constant: constant
                )
            case .bottom:
                return view.bottomAnchor.constraint(
                    equalTo: viewEqualTo.bottomAnchor,
                    constant: constant
                )
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    func obtainView(by viewID: String) -> PKView? {
        if viewID == "container" {
            return self
        }
        return obtainViewWrapper(by: viewID)?.view
    }
    
    private func obtainViewWrapper(by viewID: String) -> PKViewWrapper? {
        return viewWrappers.first(where: { viewWrapper in
            viewWrapper.viewID == viewID
        })
    }
}
