import UIKit

final class PKTextField: PKView {
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
    func apply(visualProperties: [PKViewRules.VisualPropertyKey: String]) {
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
        textField.textAlignment = determineTextAlignment(textAlignment: visualProperties[.textAlignment] ?? "")
        
        textField.autocorrectionType = determineAutocorrectionType(
            autocorrectionType: visualProperties[.autocorrectionType] ?? ""
        )
        textField.autocapitalizationType = determineAutocapitalizationType(
            autocapitalizationType: visualProperties[.autocapitalizationType] ?? ""
        )
        textField.isSecureTextEntry = determineIsSecureTextEntry(
            isSecureTextEntry: visualProperties[.isSecureTextEntry] ?? ""
        )
    }
}

extension PKTextField {
    private func determineTextAlignment(textAlignment: String) -> NSTextAlignment {
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
    
    private func determineAutocorrectionType(
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
    
    private func determineAutocapitalizationType(
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
    
    private func determineIsSecureTextEntry(
        isSecureTextEntry: String
    ) -> Bool {
        if isSecureTextEntry == "true" {
            return true
        }
        return false
    }
}
