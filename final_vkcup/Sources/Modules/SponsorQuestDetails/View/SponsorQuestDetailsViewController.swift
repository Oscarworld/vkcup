import UIKit

final class SponsorQuestDetailsViewController: UIViewController {

    // MARK: - VIPER

    var output: SponsorQuestDetailsViewOutput!

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
        let scrollView = UIScrollView()
        return $0
    }(UIScrollView())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var contentView: UIView = {
        return $0
    }(UIView())
    
    private lazy var questImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var titleView: UIView = {
        return $0
    }(UIView())
    
    private lazy var descriptionView: UIView = {
        return $0
    }(UIView())
    
    private lazy var firstSeparatorView: UIView = {
        return $0
    }(UIView())
    
    private lazy var locationView: UIView = {
        return $0
    }(UIView())
    
    private lazy var secondSeparatorView: UIView = {
        return $0
    }(UIView())
    
    private lazy var giftsView: UIView = {
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title1
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.gray
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var firstSeparator: UIView = {
        $0.backgroundColor = UIColor.Styles.separator
        return $0
    }(UIView())
    
    private lazy var locationLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var locationImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage.Styles.counterOutline
        return $0
    }(UIImageView())
    
    private lazy var secondSeparator: UIView = {
        $0.backgroundColor = UIColor.Styles.separator
        return $0
    }(UIView())
    
    private lazy var giftsLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title6
        $0.textColor = UIColor.Styles.gray
        $0.textAlignment = .left
        $0.text = "Призы".uppercased()
        return $0
    }(UILabel())
    
    private lazy var giftsLeftLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title6
        $0.textColor = UIColor.Styles.gray
        $0.textAlignment = .right
        $0.text = "осталось"
        return $0
    }(UILabel())
    
    private lazy var submitButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Перейти к заданиям",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(didPressSubmitButton), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
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

    private func setup() {
        navigationItem.title = "Квест"
    }

    private func setupView() {
        [
            scrollView,
            submitButton,
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
            titleLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            titleView.addSubview($0)
        }
        
        [
            descriptionLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.addSubview($0)
        }
        
        [
            firstSeparator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            firstSeparatorView.addSubview($0)
        }
        
        [
            locationImageView,
            locationLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            locationView.addSubview($0)
        }
        
        [
            secondSeparator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            secondSeparatorView.addSubview($0)
        }
        
        [
            giftsLabel,
            giftsLeftLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftsView.addSubview($0)
        }
        
        [
            questImageView,
            titleView,
            descriptionView,
            firstSeparatorView,
            locationView,
            secondSeparatorView,
            giftsView,
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
            scrollView.topAnchor.constraint(equalTo: viewTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -12),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            questImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -16),
            
            firstSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            firstSeparator.topAnchor.constraint(equalTo: firstSeparatorView.topAnchor),
            firstSeparator.leadingAnchor.constraint(equalTo: firstSeparatorView.leadingAnchor, constant: 16),
            firstSeparator.trailingAnchor.constraint(equalTo: firstSeparatorView.trailingAnchor, constant: -16),
            firstSeparator.bottomAnchor.constraint(equalTo: firstSeparatorView.bottomAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 12),
            
            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -12),
            locationLabel.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -16),
            
            secondSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            secondSeparator.topAnchor.constraint(equalTo: secondSeparatorView.topAnchor),
            secondSeparator.leadingAnchor.constraint(equalTo: secondSeparatorView.leadingAnchor, constant: 16),
            secondSeparator.trailingAnchor.constraint(equalTo: secondSeparatorView.trailingAnchor, constant: -16),
            secondSeparator.bottomAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor),
            
            giftsLabel.topAnchor.constraint(equalTo: giftsView.topAnchor, constant: 16),
            giftsLabel.leadingAnchor.constraint(equalTo: giftsView.leadingAnchor, constant: 16),
            giftsLabel.trailingAnchor.constraint(equalTo: giftsLeftLabel.leadingAnchor, constant: -16),
            giftsLabel.bottomAnchor.constraint(equalTo: giftsView.bottomAnchor, constant: -16),
            
            giftsLeftLabel.topAnchor.constraint(equalTo: giftsView.topAnchor, constant: 16),
            giftsLeftLabel.trailingAnchor.constraint(equalTo: giftsView.trailingAnchor, constant: -12),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressSubmitButton() {
        output.didHandleSubmitButton()
    }
}

// MARK: - SponsorQuestDetailsViewInput

extension SponsorQuestDetailsViewController: SponsorQuestDetailsViewInput {
    func setupQuest(
        _ quest: Quest,
        location: String
    ) {
        titleLabel.text = quest.title
        descriptionLabel.text = quest.description
        locationLabel.text = location
        
        if let thumbUrl = quest.steps.first?.photo,
           let url = URL(string: thumbUrl) {
            if let image = ImageCache.shared()[url] {
                questImageView.image = image
            } else {
                questImageView.load(
                    avatarUrl: thumbUrl,
                    placeholder: UIImage()
                ) { [weak self] image, _ in
                    ImageCache.shared()[url] = image
                    self?.questImageView.image = image
                }
            }
        }
        
        quest.gifts.map(makeGiftView).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func makeGiftView(
        _ gift: QuestGift
    ) -> UIView {
        let giftView = UIView()
        
        let giftImageView = UIImageView()
        giftImageView.contentMode = .scaleAspectFill
        giftImageView.clipsToBounds = true
        giftImageView.layer.cornerRadius = 8
        if let photo = gift.photo {
            giftImageView.image = photo
        } else {
            giftImageView.layer.borderWidth = 0.5
            giftImageView.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.08).cgColor
            if let photoUrl = gift.photoUrl,
               let url = URL(string: photoUrl) {
                if let image = ImageCache.shared()[url] {
                    giftImageView.image = image
                } else {
                    giftImageView.load(
                        avatarUrl: photoUrl,
                        placeholder: UIImage()
                    ) { image, _ in
                        ImageCache.shared()[url] = image
                        giftImageView.image = image
                    }
                }
            }
        }
        
        let giftTitleLabel = UILabel()
        giftTitleLabel.numberOfLines = 1
        giftTitleLabel.font = UIFont.Styles.title3
        giftTitleLabel.textColor = UIColor.Styles.black
        giftTitleLabel.textAlignment = .left
        giftTitleLabel.text = gift.title
        
        let giftDescriptionLabel = UILabel()
        giftDescriptionLabel.numberOfLines = 1
        giftDescriptionLabel.font = UIFont.Styles.subtitle2
        giftDescriptionLabel.textColor = UIColor.Styles.gray
        giftDescriptionLabel.textAlignment = .left
        giftDescriptionLabel.text = gift.description
        
        let leftLabel = UILabel()
        leftLabel.numberOfLines = 1
        leftLabel.font = UIFont.Styles.title3
        leftLabel.textColor = UIColor.Styles.gray
        leftLabel.textAlignment = .center
        leftLabel.text = "\(gift.available) шт."
        
        [
            giftImageView,
            giftTitleLabel,
            giftDescriptionLabel,
            leftLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftView.addSubview($0)
        }
        
        leftLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        leftLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            giftImageView.widthAnchor.constraint(equalToConstant: 48),
            giftImageView.heightAnchor.constraint(equalToConstant: 48),
            giftImageView.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 6),
            giftImageView.leadingAnchor.constraint(equalTo: giftView.leadingAnchor, constant: 12),
            giftImageView.bottomAnchor.constraint(equalTo: giftView.bottomAnchor, constant: -6),
            
            giftTitleLabel.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 10),
            giftTitleLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftTitleLabel.trailingAnchor.constraint(equalTo: leftLabel.leadingAnchor, constant: -12),
            
            giftDescriptionLabel.topAnchor.constraint(equalTo: giftTitleLabel.bottomAnchor, constant: 3),
            giftDescriptionLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftDescriptionLabel.trailingAnchor.constraint(equalTo: leftLabel.leadingAnchor, constant: -12),
            
            leftLabel.centerYAnchor.constraint(equalTo: giftView.centerYAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: giftView.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
        
        if gift.available == 0 {
            giftView.layer.opacity = 0.5
        }
        
        return giftView
    }
}

// MARK: - SponsorQuestDetailsTransitionHandler

extension SponsorQuestDetailsViewController: SponsorQuestDetailsTransitionHandler { }

// MARK: - Localization

private extension SponsorQuestDetailsViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SponsorQuestDetailsViewController {
    enum Constants { }
}
