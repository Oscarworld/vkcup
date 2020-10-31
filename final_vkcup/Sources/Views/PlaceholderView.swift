import UIKit

final class PlaceholderView: UIView {
    
    // MARK: - Value properties
    
    public var action: (() -> Void) = { }
    
    public var actionButtonTitle: String? {
        set {
            if let value = newValue {
                let attributedString = NSAttributedString(
                    string: value,
                    attributes: [
                        .font: UIFont.Styles.title1,
                        .foregroundColor: UIColor.Styles.primary
                    ]
                )
                actionButton.setAttributedTitle(attributedString, for: .normal)
                actionButton.isHidden = false
            } else {
                actionButton.setAttributedTitle(nil, for: .normal)
                actionButton.isHidden = true
            }
        }
        get {
            return actionButton.attributedTitle(for: .normal)?.string
                ?? actionButton.currentTitle
        }
    }
    
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    public var subtitle: String? {
        set {
            subtitleLabel.text = newValue
        }
        get {
            return subtitleLabel.text
        }
    }
    
    // MARK: - UI properties
    
    private(set) lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = Constants.titleFont
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private(set) lazy var subtitleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = Constants.subtitleFont
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private(set) lazy var actionButton: UIButton = {
        $0.addTarget(self, action: #selector(didPressActionButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Actions
    
    @objc
    private func didPressActionButton() {
        action()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupView()
    }
    
    // MARK: - Setup

    private func setupView() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [
            titleLabel,
            subtitleLabel,
            actionButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLeftInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.titleRightInset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.titleCentextYInset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleTopInset),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.subtitleLeftInset),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.subtitleRightInset),
            
            actionButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.buttonTopInset),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.buttonLeftInset),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.buttonRightInset),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Constants

private extension PlaceholderView {
    enum Constants {
        static let titleFont = UIFont.Styles.title
        static let subtitleFont = UIFont.Styles.subtitle
        
        static let titleCentextYInset: CGFloat = 32
        static let titleLeftInset: CGFloat = 32
        static let titleRightInset: CGFloat = 32
        
        static let subtitleTopInset: CGFloat = 8
        static let subtitleLeftInset: CGFloat = 32
        static let subtitleRightInset: CGFloat = 32
        
        static let buttonTopInset: CGFloat = 8
        static let buttonLeftInset: CGFloat = 32
        static let buttonRightInset: CGFloat = 32
    }
}

