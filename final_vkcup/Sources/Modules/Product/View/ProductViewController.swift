import UIKit

final class ProductViewController: UIViewController {

    // MARK: - VIPER

    var output: ProductViewOutput!

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
    
    private lazy var headerView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var titleHeaderLabel: UILabel = {
        $0.textColor = UIColor.Styles.black
        $0.font = UIFont.Styles.title2
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var closeButton: UIButton = {
        $0.setImage(UIImage.Styles.back, for: .normal)
        $0.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
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
    
    private lazy var avatarView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var descriptionView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var avatarImageView: UIImageView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title4
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var subtitleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title5
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var favoriteButtonView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var favoriteButton: UIButton = {
        $0.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.Styles.white
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            headerView,
            scrollView,
            favoriteButtonView,
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
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [
            closeButton,
            titleHeaderLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }
        
        [
            avatarImageView,
            activityIndicator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            avatarView.addSubview($0)
        }
        
        [
            titleLabel,
            subtitleLabel,
            descriptionLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.addSubview($0)
        }
        
        [
            favoriteButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            favoriteButtonView.addSubview($0)
        }
        
        [
            avatarView,
            descriptionView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }

    private func setupConstraints() {
        let viewTopAnchor: NSLayoutYAxisAnchor
        let viewBottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            viewTopAnchor = view.safeAreaLayoutGuide.topAnchor
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewTopAnchor = topLayoutGuide.bottomAnchor
            viewBottomAnchor = bottomLayoutGuide.topAnchor
        }
        let constraints = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleHeaderLabel.topAnchor.constraint(equalTo: viewTopAnchor, constant: 12),
            titleHeaderLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 36),
            titleHeaderLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -36),
            titleHeaderLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            
            closeButton.centerYAnchor.constraint(equalTo: titleHeaderLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: favoriteButtonView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -10),
            
            favoriteButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: favoriteButtonView.topAnchor, constant: 12),
            favoriteButton.leadingAnchor.constraint(equalTo: favoriteButtonView.leadingAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: favoriteButtonView.trailingAnchor, constant: -12),
            favoriteButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressBackButton() {
        output.didPressBackButton()
    }
    
    @objc
    private func didPressFavoriteButton() {
        output.didPressFavoriteButton()
    }
}

// MARK: - ProductViewInput

extension ProductViewController: ProductViewInput {
    func setupViewModel(
        _ viewModel: BriefProductViewModel
    ) {
        titleHeaderLabel.text = viewModel.title
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        
        guard let avatarUrl = viewModel.avatarUrl,
              let url = URL(string: avatarUrl) else { return }
        activityIndicator.startAnimating()
        avatarImageView.isHidden = true
        avatarImageView.load(url: url) { [weak self] image in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.avatarImageView.isHidden = false
            self.avatarImageView.image = image
        }
    }
    
    func setupIsFavorite(
        _ isFavorite: Bool
    ) {
        let buttonText = isFavorite
            ? Localized.removeFromFavoriteButtonTitle
            : Localized.addToFavoriteButtonTitle
        let buttonTextColor = isFavorite
            ? UIColor.Styles.second
            : UIColor.Styles.white
        let buttonBacgkround = isFavorite
            ? UIColor(red: 0.0 / 255.0, green: 28.0 / 255.0, blue: 61.0 / 255.0, alpha: 0.05)
            : UIColor.Styles.primary
            
        let attributedString = NSAttributedString(
            string: buttonText,
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: buttonTextColor
            ]
        )
        favoriteButton.setAttributedTitle(attributedString, for: .normal)
        favoriteButton.backgroundColor = buttonBacgkround
    }
    
    func showActivityOverCurrentContext() {
        self.showSpinner(onView: view)
    }
    
    func hideActivityOverCurrentContext() {
        self.removeSpinner(fromView: view)
    }
}

// MARK: - ProductTransitionHandler

extension ProductViewController: ProductTransitionHandler { }

// MARK: - Localization

private extension ProductViewController {
    enum Localized {
        // swiftlint:disable line_length
        static let addToFavoriteButtonTitle = NSLocalizedString(
            "ProductViewController.AddToFavoriteButtonTitle",
            value: "Выбрать",
            comment: "Title на кнопке `Добавить в избранное`"
        )
        static let removeFromFavoriteButtonTitle = NSLocalizedString(
            "ProductViewController.RemoveFromFavoriteButtonTitle",
            value: "Удалить из избранного",
            comment: "Title на кнопке `Удалить из избранного`"
        )
        // swiftlint:enable line_length
    }
}
