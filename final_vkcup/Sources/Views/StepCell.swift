final class StepCell: UITableViewCell {
    
    // MARK: - Output
    
    public var output: (() -> Void)?
    
    // MARK: - UI properties
    
    public lazy var photoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    public lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title1
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    public lazy var descriptionImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.descriptionOutline
        return $0
    }(UIImageView())
    
    public lazy var descriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    public lazy var locationImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.counterOutline
        return $0
    }(UIImageView())
    
    public lazy var locationLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    public lazy var stepButton: UIButton = {
//        let attributedString = NSAttributedString(
//            string: Localized.openButtonTitle,
//            attributes: [
//                .font: UIFont.Styles.title2,
//                .foregroundColor: UIColor.Styles.white
//            ]
//        )
//        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(didPressStepButton), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    private lazy var bottomView: UIView = {
        $0.backgroundColor = UIColor.Styles.gray
        return $0
    }(UIView())
    
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
            photoImageView,
            titleLabel,
            descriptionImageView,
            descriptionLabel,
            locationImageView,
            locationLabel,
            stepButton,
            bottomView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            descriptionImageView.widthAnchor.constraint(equalToConstant: 20),
            descriptionImageView.heightAnchor.constraint(equalToConstant: 20),
            descriptionImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            stepButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 24),
            stepButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stepButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stepButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stepButton.heightAnchor.constraint(equalToConstant: 44),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 0.5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Action
    
    @objc
    private func didPressStepButton() {
        output?()
    }
}
