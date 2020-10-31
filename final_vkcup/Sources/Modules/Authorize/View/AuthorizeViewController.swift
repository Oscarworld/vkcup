import UIKit

final class AuthorizeViewController: UIViewController {

    // MARK: - VIPER

    var output: AuthorizeViewOutput!

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
    
    private lazy var activityIndecator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var authorizeButton: UIButton = {
        let attributedString = NSAttributedString(
            string: Localized.authorizeButtonTitle,
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.primary
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(didPressAuthorize), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var logoImageView: UIImageView = {
        $0.image = UIImage.Styles.vkLogo
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: - Setup

    private func setup() {
        
    }

    private func setupView() {
        [
            authorizeButton,
            logoImageView,
            activityIndecator,
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
            activityIndecator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndecator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            authorizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            authorizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            authorizeButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -32),
            authorizeButton.heightAnchor.constraint(equalToConstant: 44),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: viewTopAnchor, constant: 64),
            logoImageView.widthAnchor.constraint(equalToConstant: 192),
            logoImageView.heightAnchor.constraint(equalToConstant: 192),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressAuthorize() {
        output.didPressAuthorize()
    }
}

// MARK: - AuthorizeViewInput

extension AuthorizeViewController: AuthorizeViewInput {
    func showActivity() {
        authorizeButton.isHidden = true
        activityIndecator.startAnimating()
    }
    
    func hideActivity() {
        authorizeButton.isHidden = false
        activityIndecator.stopAnimating()
    }
}

// MARK: - AuthorizeTransitionHandler

extension AuthorizeViewController: AuthorizeTransitionHandler {
    func needPresentCaptchaEnter(_ captchaError: VKError!) {
        output.showCaptchaEnter(captchaError, in: self)
    }
}

// MARK: - Localization

private extension AuthorizeViewController {
    enum Localized {
        // swiftlint:disable line_length
        static let authorizeButtonTitle = NSLocalizedString(
            "AuthorizeViewController.AuthorizeButtonTitle",
            value: "Войти",
            comment: "Title кнопки авторизации на экране Авторизации"
        )
        // swiftlint:enable line_length
    }
}
