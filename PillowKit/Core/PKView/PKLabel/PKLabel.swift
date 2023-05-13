import UIKit

final class PKLabel: UIView {
    private let label: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PKLabel {
    private func setupUI() {
        setupLabel()
    }

    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PKLabel: PKViewProtocol {
    func apply(visualProperties: [PKViewRules.VisualPropertyKey : String]) {
        label.clipsToBounds = true
        
        label.backgroundColor = UIColor(hex: visualProperties[.backgroundColor] ?? "#a83232ff")
        label.layer.cornerRadius = CGFloat(Double(visualProperties[.cornerRadius] ?? "") ?? 0.0)
        label.layer.borderColor = UIColor(hex: visualProperties[.borderColor] ?? "#000000ff")?.cgColor
        label.layer.borderWidth = CGFloat(Double(visualProperties[.borderWidth] ?? "") ?? 0.0)
        
        label.text = visualProperties[.text] ?? ""
        label.font = UIFont(
            name: visualProperties[.font] ?? "",
            size: CGFloat(Double(visualProperties[.fontSize] ?? "") ?? 11.0)
        )
        label.textAlignment = detectTextAlignment(textAlignment: visualProperties[.textAlignment] ?? "")
        label.numberOfLines = 0  // Configure it in the future
    }
}
 
extension PKLabel {
    private func detectTextAlignment(textAlignment: String) -> NSTextAlignment {
        if textAlignment == "center" {
            return .center
        }
        if textAlignment == "left" {
            return .left
        }
        if textAlignment == "right" {
            return .right
        }
        return .left
    }
}
