import UIKit

class PaginationIndicatorView : UITableViewCell {
   
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
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
            activityIndicator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
