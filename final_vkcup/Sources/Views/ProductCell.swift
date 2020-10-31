import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: - Value properties
    
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
    
    public let logoImageView: UIImageView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.08).cgColor
        $0.layer.borderWidth = 0.5
        return $0
    }(UIImageView())
    
    private(set) lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.Styles.subtitle5
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private(set) lazy var subtitleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.Styles.subtitle6
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
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
        backgroundColor = UIColor.Styles.white
        contentView.backgroundColor = UIColor.Styles.white
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        [
            logoImageView,
            titleLabel,
            subtitleLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Calculate height

extension ProductCell {
    static func calculateHeight(
        width: CGFloat,
        title: String,
        subtitle: String
    ) -> CGFloat {
        let titleHeight = title.height(
            fits: width,
            font: UIFont.Styles.subtitle5
        )
        let subtitleHeight = subtitle.height(
            fits: width,
            font: UIFont.Styles.subtitle6
        )
        return width
            + titleHeight
            + subtitleHeight
            + 24
    }
}
