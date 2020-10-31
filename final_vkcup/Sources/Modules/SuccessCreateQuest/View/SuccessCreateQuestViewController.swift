import UIKit

final class SuccessCreateQuestViewController: UIViewController {

    // MARK: - VIPER

    var output: SuccessCreateQuestViewOutput!

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
    
    private lazy var treasureImageView: UIImageView = {
        $0.image = UIImage.Styles.successMap
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var successTitleLabel: UILabel = {
        $0.textAlignment = .center
        $0.text = "Поздравляем!"
        $0.font = UIFont.Styles.title8
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var successSubtitleLabel: UILabel = {
        $0.textAlignment = .center
        $0.text = "Вы успешно создали персональный квест"
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var shareButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Поделиться",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
//        $0.addTarget(self, action: #selector(didPressSubmitButton), for: .touchUpInside)
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

    private func setup() { }

    private func setupView() {
        [
            treasureImageView,
            successTitleLabel,
            successSubtitleLabel,
            shareButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
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
            treasureImageView.topAnchor.constraint(equalTo: viewTopAnchor, constant: 128),
            treasureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            treasureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            treasureImageView.heightAnchor.constraint(equalTo: treasureImageView.widthAnchor),
            
            successTitleLabel.topAnchor.constraint(equalTo: treasureImageView.bottomAnchor, constant: 64),
            successTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            successSubtitleLabel.topAnchor.constraint(equalTo: successTitleLabel.bottomAnchor, constant: 16),
            successSubtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shareButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
}

// MARK: - SuccessCreateQuestViewInput

extension SuccessCreateQuestViewController: SuccessCreateQuestViewInput { }

// MARK: - SuccessCreateQuestTransitionHandler

extension SuccessCreateQuestViewController: SuccessCreateQuestTransitionHandler { }

// MARK: - Localization

private extension SuccessCreateQuestViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SuccessCreateQuestViewController {
    enum Constants { }
}
