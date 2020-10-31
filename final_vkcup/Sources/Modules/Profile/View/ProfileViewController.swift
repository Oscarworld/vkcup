import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - VIPER

    var output: ProfileViewOutput!

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

    // MARK: - Setup

    private func setup() {
        tabBarItem.title = "Профиль"
        tabBarItem.image = UIImage.Styles.profileOutline
        tabBarItem.selectedImage = UIImage.Styles.profileOutline
    }

    private func setupView() { }

    private func setupConstraints() { }

    // MARK: - Action
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput { }

// MARK: - ProfileTransitionHandler

extension ProfileViewController: ProfileTransitionHandler { }

// MARK: - Localization

private extension ProfileViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension ProfileViewController {
    enum Constants { }
}
