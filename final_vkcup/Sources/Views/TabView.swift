import UIKit

final class TabView: UIView {
    
    // MARK: - Value properties
    
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    public var isActive: Bool = false {
        didSet {
            if isActive {
                titleLabel.textColor = UIColor.Styles.black
                borderLine.isHidden = false
            } else {
                titleLabel.textColor = UIColor.Styles.gray1
                borderLine.isHidden = true
            }
        }
    }
    
    public var isHiddenCounter: Bool = true {
        didSet {
            counterImageView.isHidden = isHiddenCounter
        }
    }
    
    // MARK: - UI properties
    
    private(set) lazy var titleLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = UIFont.Styles.title3
        return $0
    }(UILabel())
    
    private(set) lazy var borderLine: UIView = {
        $0.backgroundColor = UIColor.Styles.second
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    private(set) lazy var counterImageView: UIImageView = {
        $0.image = UIImage.Styles.counterSmall
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
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
            counterImageView,
            borderLine,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13.5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            counterImageView.heightAnchor.constraint(equalToConstant: 16),
            counterImageView.widthAnchor.constraint(equalToConstant: 16),
            counterImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            counterImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            borderLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.5),
            borderLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            borderLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            borderLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            borderLine.heightAnchor.constraint(equalToConstant: 2),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
