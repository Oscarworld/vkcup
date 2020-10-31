import UIKit

final class SelectCell: UITableViewCell {
    
    // MARK: - Value properties
    
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    // MARK: - UI properties
    
    public lazy var titleLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.title7
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    public lazy var checkmarkImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor.Styles.white
        $0.image = UIImage.Styles.checkmark
        return $0
    }(UIImageView())
    
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
            titleLabel,
            checkmarkImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -16),
            
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
