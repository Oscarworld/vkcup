final class StepSection: UITableViewHeaderFooterView {
    
    // MARK: - UI properties
    
    public lazy var titleLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.title2
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    public lazy var checkmarkImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor.Styles.white
        $0.image = UIImage.Styles.checkmark
        return $0
    }(UIImageView())
    
    private lazy var bottomView: UIView = {
        $0.backgroundColor = UIColor.Styles.gray
        return $0
    }(UIView())
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            titleLabel,
            checkmarkImageView,
            bottomView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -12),
            
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 0.5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
