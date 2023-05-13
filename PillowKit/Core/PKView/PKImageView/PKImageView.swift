import UIKit

final class PKImageView: UIView {
    private let imageView: UIImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PKImageView {
    private func setupUI() {
        setupImageView()
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PKImageView: PKViewProtocol {
    func apply(visualProperties: [PKViewRules.VisualPropertyKey : String]) {
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = CGFloat(Double(visualProperties[.cornerRadius] ?? "") ?? 0.0)
        imageView.layer.borderColor = UIColor(hex: visualProperties[.borderColor] ?? "#000000ff")?.cgColor
        imageView.layer.borderWidth = CGFloat(Double(visualProperties[.borderWidth] ?? "") ?? 0.0)
        
        if let imageURL = URL(string: visualProperties[.imageURL] ?? "") {
            imageView.load(url: imageURL)
        }
        imageView.contentMode = .scaleAspectFill  // Configure it in the future
    }
}
