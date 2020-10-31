import UIKit

final class QuestDetailsViewController: UIViewController {

    // MARK: - VIPER

    var output: QuestDetailsViewOutput!

    // MARK: - Data

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - UI properties
    
    private lazy var scrollView: UIScrollView = {
        $0.alwaysBounceVertical = true
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        return $0
    }(UIView())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private lazy var activityIndecator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var titleView: UIView = {
        $0.backgroundColor = UIColor.clear
        return $0
    }(UIView())
    
    private lazy var locationView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var counterView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var descriptionView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var lastPostView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var openGroupButtonView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title1
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        $0.text = " "
        return $0
    }(UILabel())
    
    private lazy var locationLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        $0.text = " "
        return $0
    }(UILabel())
    
    private lazy var counterLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        $0.text = " "
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        $0.text = " "
        return $0
    }(UILabel())
    
    private lazy var lastPostLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        $0.text = " "
        return $0
    }(UILabel())
    
    private lazy var locationImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.counterOutline
        return $0
    }(UIImageView())
    
    private lazy var counterImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.members
        return $0
    }(UIImageView())
    
    private lazy var descriptionImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.descriptionOutline
        return $0
    }(UIImageView())
    
    private lazy var lastPostImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.giftOutline
        return $0
    }(UIImageView())
    
    private lazy var closeButton: UIButton = {
        $0.setImage(UIImage.Styles.close, for: .normal)
        $0.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        $0.imageView?.contentMode = .scaleAspectFit
        return $0
    }(UIButton())
    
    private lazy var openGroupButton: UIButton = {
        $0.addTarget(self, action: #selector(didPressOpenButton), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    // MARK: - Dynamics constraints
    
    fileprivate lazy var scrollViewHeightConstraint: NSLayoutConstraint = {
        $0.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        return $0
    }(self.scrollView.heightAnchor.constraint(equalToConstant: 0))

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.setupScrollViewHeight()
        }
    }

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            scrollView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            contentView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        [
            stackView,
            activityIndecator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [
            titleLabel,
            closeButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            titleView.addSubview($0)
        }
        
        [
            locationLabel,
            locationImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            locationView.addSubview($0)
        }
        
        [
            counterLabel,
            counterImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            counterView.addSubview($0)
        }
        
        [
            descriptionLabel,
            descriptionImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.addSubview($0)
        }
        
        [
            lastPostLabel,
            lastPostImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            lastPostView.addSubview($0)
        }
        
        [
            openGroupButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            openGroupButtonView.addSubview($0)
        }
        
        [
            titleView,
            locationView,
            counterView,
            descriptionView,
            lastPostView,
            openGroupButtonView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }

    private func setupConstraints() {
        let constraints = [
            scrollViewHeightConstraint,
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndecator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndecator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -4),
            
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 4),
            closeButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -4),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 8),
            locationImageView.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 12),
            
            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -12),
            locationLabel.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -8),
            
            counterImageView.widthAnchor.constraint(equalToConstant: 20),
            counterImageView.heightAnchor.constraint(equalToConstant: 20),
            counterImageView.topAnchor.constraint(equalTo: counterView.topAnchor, constant: 8),
            counterImageView.leadingAnchor.constraint(equalTo: counterView.leadingAnchor, constant: 12),
            
            counterLabel.topAnchor.constraint(equalTo: counterView.topAnchor, constant: 8),
            counterLabel.leadingAnchor.constraint(equalTo: counterImageView.trailingAnchor, constant: 12),
            counterLabel.trailingAnchor.constraint(equalTo: counterView.trailingAnchor, constant: -12),
            counterLabel.bottomAnchor.constraint(equalTo: counterView.bottomAnchor, constant: -8),
            
            descriptionImageView.widthAnchor.constraint(equalToConstant: 20),
            descriptionImageView.heightAnchor.constraint(equalToConstant: 20),
            descriptionImageView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionImageView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -8),
            
            lastPostImageView.widthAnchor.constraint(equalToConstant: 20),
            lastPostImageView.heightAnchor.constraint(equalToConstant: 20),
            lastPostImageView.topAnchor.constraint(equalTo: lastPostView.topAnchor, constant: 8),
            lastPostImageView.leadingAnchor.constraint(equalTo: lastPostView.leadingAnchor, constant: 12),
            
            lastPostLabel.topAnchor.constraint(equalTo: lastPostView.topAnchor, constant: 8),
            lastPostLabel.leadingAnchor.constraint(equalTo: lastPostImageView.trailingAnchor, constant: 12),
            lastPostLabel.trailingAnchor.constraint(equalTo: lastPostView.trailingAnchor, constant: -12),
            lastPostLabel.bottomAnchor.constraint(equalTo: lastPostView.bottomAnchor, constant: -8),
            
            openGroupButton.topAnchor.constraint(equalTo: openGroupButtonView.topAnchor, constant: 24),
            openGroupButton.leadingAnchor.constraint(equalTo: openGroupButtonView.leadingAnchor, constant: 12),
            openGroupButton.trailingAnchor.constraint(equalTo: openGroupButtonView.trailingAnchor, constant: -12),
            openGroupButton.bottomAnchor.constraint(equalTo: openGroupButtonView.bottomAnchor, constant: -12),
            openGroupButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupScrollViewHeight() {
        guard let window = view.window else { return }
        let scrollViewContentHeight = scrollView.contentSize.height
            + UIScreen.safeAreaInsets.bottom
        let scrollViewHeight = min(scrollViewContentHeight, window.frame.height)
        
        if scrollViewHeightConstraint.constant != scrollViewHeight {
            scrollViewHeightConstraint.constant = scrollViewHeight
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
        
        scrollView.isScrollEnabled = scrollViewContentHeight > scrollViewHeight
    }

    // MARK: - Action
    
    @objc
    private func didPressOpenButton() {
        output.didPressOpenButton()
    }
    
    @objc
    private func didPressCloseButton() {
        output.didPressCloseButton()
    }
}

// MARK: - QuestDetailsViewInput

extension QuestDetailsViewController: QuestDetailsViewInput {
    func setViewModel(
        title: String,
        description: String,
        location: String,
        owner: String,
        gifts: String
    ) {
        titleLabel.text = title
        descriptionLabel.text = description
        locationLabel.text = location
        counterLabel.text = owner
        lastPostLabel.text = gifts
    }
    
    func showActivity() {
        setContentIsHidden(true)
        activityIndecator.startAnimating()
    }
    
    func hideActivity() {
        setContentIsHidden(false)
        view.setNeedsLayout()
        activityIndecator.stopAnimating()
    }
    
    func setupButtonTitle(
        _ title: String
    ) {
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        openGroupButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func setContentIsHidden(_ isHidden: Bool) {
        titleLabel.isHidden = isHidden
        locationLabel.isHidden = isHidden
        counterLabel.isHidden = isHidden
        descriptionLabel.isHidden = isHidden
        lastPostLabel.isHidden = isHidden
        locationImageView.isHidden = isHidden
        counterImageView.isHidden = isHidden
        descriptionImageView.isHidden = isHidden
        lastPostImageView.isHidden = isHidden
        openGroupButton.isHidden = isHidden
    }
}

// MARK: - QuestDetailsTransitionHandler

extension QuestDetailsViewController: QuestDetailsTransitionHandler { }

// MARK: - Localization

private extension QuestDetailsViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QuestDetailsViewController {
    enum Constants { }
}
