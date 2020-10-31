import UIKit

final class ImageViewerViewController: UIViewController {

    // MARK: - VIPER

    var output: ImageViewerViewOutput!

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
        $0.backgroundColor = UIColor.Styles.black
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Фотография"
        $0.textColor = UIColor.Styles.white
        $0.font = UIFont.Styles.title2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var closeButton: UIButton = {
        $0.setImage(UIImage.Styles.back, for: .normal)
        $0.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        return $0
    }(UIButton())

    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    // MARK: - Managing the View
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.Styles.black
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
            imageView,
            headerView,
            activityIndicator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            closeButton,
            titleLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
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
            
            titleLabel.topAnchor.constraint(equalTo: viewTopAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 72),
            
            imageView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewBottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ImageViewerViewInput

extension ImageViewerViewController: ImageViewerViewInput {
    func loadImage(_ url: URL) {
        activityIndicator.startAnimating()
        imageView.isHidden = true
        imageView.load(url: url) { [weak self] image in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.imageView.isHidden = false
            self.imageView.image = image
        }
    }
}

// MARK: - Localization

private extension ImageViewerViewController {
    enum Localized {
        // swiftlint:disable line_length
        static let closeTitle = NSLocalizedString(
            "ImageViewerViewController.Close",
            value: "Закрыть",
            comment: "Title кнопки `Закрыть`"
        )
        // swiftlint:enable line_length
    }
}
