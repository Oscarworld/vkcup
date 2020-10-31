import UIKit

final class QRScanViewController: UIViewController {

    // MARK: - VIPER

    var output: QRScanViewOutput!

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
        tabBarItem.title = "Сканировать"
        tabBarItem.image = UIImage.Styles.qrCodeScanOutline
        tabBarItem.selectedImage = UIImage.Styles.qrCodeScanOutline
    }

    private func setupView() { }

    private func setupConstraints() { }

    // MARK: - Action
}

// MARK: - QRScanViewInput

extension QRScanViewController: QRScanViewInput { }

// MARK: - QRScanTransitionHandler

extension QRScanViewController: QRScanTransitionHandler { }

// MARK: - Localization

private extension QRScanViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QRScanViewController {
    enum Constants { }
}
