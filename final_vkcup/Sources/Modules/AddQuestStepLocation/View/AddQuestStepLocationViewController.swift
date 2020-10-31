import UIKit
import GoogleMaps

final class AddQuestStepLocationViewController: UIViewController {

    // MARK: - VIPER

    var output: AddQuestStepLocationViewOutput!

    // MARK: - Data
    
    private let locationManager = CLLocationManager()
    private let defaultCameraPosition = GMSCameraPosition(
        latitude: 59.93863,
        longitude: 30.31413,
        zoom: 16.0
    )

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
    
    private lazy var addressLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = UIColor.Styles.black
        $0.font = UIFont.Styles.title3
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var selectedImageView: UIImageView = {
        $0.image = UIImage.Styles.placeOutline
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var selectLocationButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Выбрать",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.backgroundColor = UIColor.Styles.primary
        $0.addTarget(
            self,
            action: #selector(didPressSelectLocation),
            for: .touchUpInside
        )
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    private lazy var mapView: GMSMapView = {
        $0.camera = defaultCameraPosition
        $0.isMyLocationEnabled = false
        $0.settings.myLocationButton = false
        $0.delegate = self
        return $0
    }(GMSMapView())

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
        output.moveCamera(
            lat: mapView.camera.target.latitude,
            lon: mapView.camera.target.longitude
        )
    }
    
    private lazy var imageCenterYConstraint: NSLayoutConstraint = {
        return selectedImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
    }()

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            mapView,
            addressLabel,
            selectedImageView,
            selectLocationButton,
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
            addressLabel.topAnchor.constraint(equalTo: viewTopAnchor, constant: 24),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            selectedImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            imageCenterYConstraint,
            selectedImageView.widthAnchor.constraint(equalToConstant: 60),
            selectedImageView.heightAnchor.constraint(equalToConstant: 60),
            
            selectLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            selectLocationButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            selectLocationButton.heightAnchor.constraint(equalToConstant: 44),
            
            mapView.topAnchor.constraint(equalTo: viewTopAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressSelectLocation() {
        output.didHandleSelectLocation(
            address: addressLabel.text ?? "Не удалось определить адрес",
            lat: mapView.camera.target.latitude,
            lon: mapView.camera.target.longitude
        )
    }
}

// MARK: - AddQuestStepLocationViewInput

extension AddQuestStepLocationViewController: AddQuestStepLocationViewInput {
    func setupAddress(
        _ address: String
    ) {
        addressLabel.text = address
    }
}

// MARK: - AddQuestStepLocationTransitionHandler

extension AddQuestStepLocationViewController: AddQuestStepLocationTransitionHandler { }

// MARK: - GMUClusterManagerDelegate

extension AddQuestStepLocationViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        imageCenterYConstraint.constant = -12
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        imageCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(
        _ mapView: GMSMapView,
        didChange position: GMSCameraPosition
    ) {
        output.moveCamera(
            lat: position.target.latitude,
            lon: position.target.longitude
        )
    }
}

// MARK: - Localization

private extension AddQuestStepLocationViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddQuestStepLocationViewController {
    enum Constants { }
}
