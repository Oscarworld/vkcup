import UIKit

final class GroupCell: UITableViewCell {
    
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
    
    public lazy var logoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 24
        $0.backgroundColor = UIColor.Styles.white
        $0.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.08).cgColor
        $0.layer.borderWidth = 0.5
        return $0
    }(UIImageView())
    
    public lazy var titleLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.subtitle
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private(set) lazy var subtitleLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.subtitle5
        $0.textColor = UIColor(red: 129.0 / 255.0, green: 140.0 / 255.0, blue: 153.0 / 255.0, alpha: 1)
        return $0
    }(UILabel())
    
    private(set) lazy var contentTitlesView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            contentTitlesView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [
            titleLabel,
            subtitleLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentTitlesView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            
            contentTitlesView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            contentTitlesView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            contentTitlesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: contentTitlesView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentTitlesView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentTitlesView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentTitlesView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentTitlesView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentTitlesView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
