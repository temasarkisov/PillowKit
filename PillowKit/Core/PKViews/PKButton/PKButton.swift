import UIKit

final class PKButton: PKView {
    private let button: UIButton = UIButton()
    private var tapAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PKButton {
    private func setupUI() {
        setupButton()
    }

    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PKButton {
    func setTapAction(tapAction: @escaping () -> Void) {
        self.tapAction = tapAction
    }
}

extension PKButton: PKViewProtocol {
    func apply(visualProperties: [PKViewRules.VisualPropertyKey : String]) {
        button.clipsToBounds = true
        
        button.backgroundColor = UIColor(hex: visualProperties[.backgroundColor] ?? "#a83232ff")
        button.layer.cornerRadius = CGFloat(Double(visualProperties[.cornerRadius] ?? "") ?? 0.0)
        button.layer.borderColor = UIColor(hex: visualProperties[.borderColor] ?? "#000000ff")?.cgColor
        button.layer.borderWidth = CGFloat(Double(visualProperties[.borderWidth] ?? "") ?? 0.0)
        
        button.setTitle(visualProperties[.text] ?? "", for: .normal)
        button.titleLabel?.font = UIFont(
            name: visualProperties[.font] ?? "",
            size: CGFloat(Double(visualProperties[.fontSize] ?? "") ?? 11.0)
        )
        button.setTitleColor(UIColor(hex: visualProperties[.textColor] ?? "#000000ff"), for: .normal)
        button.titleLabel?.textAlignment = determineTextAlignment(
            textAlignment: visualProperties[.textAlignment] ?? ""
        )
        button.titleLabel?.numberOfLines = 0  // Configure it in the future
        
        button.isUserInteractionEnabled = determineIsUserInteractionEnabled(
            isUserInteractionEnabled: visualProperties[.isUserInteractionEnabled] ?? ""
        )
    }
    
    func apply(visualEffects: [PKViewRules.VisualEffectKey : String]) {
        guard let tapGestureRecognizer = proceedTapEffect(tapEffect: visualEffects[.tapEffect] ?? "") else {
            return
        }
        button.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension PKButton {
    private func proceedTapEffect(tapEffect: String) -> UITapGestureRecognizer? {
        if tapEffect.isEmpty {
            return UITapGestureRecognizer(
                target: self,
                action: #selector(didTapWithNoEffect)
            )
        }
        if tapEffect == "pulse" {
            return UITapGestureRecognizer(
                target: self,
                action: #selector(didTapWithPulseEffect)
            )
        }
        
        return nil
    }
    
    @objc
    private func didTapWithNoEffect() {
        self.tapAction?()
    }
    
    @objc
    private func didTapWithPulseEffect() {
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                guard let this = self else { return }
                this.button.layer.cornerRadius = this.button.layer.cornerRadius + 5
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        self.button.layer.cornerRadius = self.button.layer.cornerRadius - 5
                    },
                    completion: { _ in
                        self.tapAction?()
                    }
                )
            }
        )
    }
}
    
extension PKButton {
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
    
    private func determineIsUserInteractionEnabled(isUserInteractionEnabled: String) -> Bool {
        if isUserInteractionEnabled == "true" {
            return true
        }
        return false
    }
}

