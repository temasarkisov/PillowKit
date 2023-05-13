import UIKit

final class PKTextField: UIView {
    private let textField: UITextField = PKTextFieldWithPadding()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PKTextField {
    private func setupUI() {
        setupTextField()
    }

    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PKTextField: PKViewProtocol {
    func apply(visualProperties: [PKViewRules.VisualPropertyKey : String]) {
        textField.clipsToBounds = true
        
        textField.layer.cornerRadius = CGFloat(Double(visualProperties[.cornerRadius] ?? "") ?? 0.0)
        textField.layer.borderColor = UIColor(hex: visualProperties[.borderColor] ?? "#000000ff")?.cgColor
        textField.layer.borderWidth = CGFloat(Double(visualProperties[.borderWidth] ?? "") ?? 0.0)
        
        textField.placeholder = visualProperties[.placeholder] ?? ""
        textField.font = UIFont(
            name: visualProperties[.font] ?? "",
            size: CGFloat(Double(visualProperties[.fontSize] ?? "") ?? 11.0)
        )
        textField.textColor = UIColor(hex: visualProperties[.textColor] ?? "#ffffffff")
        textField.textAlignment = detectTextAlignment(textAlignment: visualProperties[.textAlignment] ?? "")
        
        textField.autocorrectionType = detectAutocorrectionType(
            autocorrectionType: visualProperties[.autocorrectionType] ?? ""
        )
        textField.autocapitalizationType = detectAutocapitalizationType(
            autocapitalizationType: visualProperties[.autocapitalizationType] ?? ""
        )
    }
}

extension PKTextField {
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
    
    private func detectAutocorrectionType(
        autocorrectionType: String
    ) -> UITextAutocorrectionType {
        if autocorrectionType == "true" {
            return .yes
        }
        if autocorrectionType == "false" {
            return .no
        }
        if autocorrectionType == "default" {
            return .default
        }
        return .default
    }
    
    private func detectAutocapitalizationType(
        autocapitalizationType: String
    ) -> UITextAutocapitalizationType {
        if autocapitalizationType == "sentences" {
            return .sentences
        }
        if autocapitalizationType == "words" {
            return .words
        }
        if autocapitalizationType == "all_characters" {
            return .allCharacters
        }
        if autocapitalizationType == "false" {
            return .none
        }
        return .sentences
    }
}
