import UIKit
import GoogleMaps
import GoogleMapsUtils

final class ContentMapViewController: UIViewController {

    // MARK: - VIPER

    var output: ContentMapViewOutput!

    // MARK: - Data
    
    private let locationManager = CLLocationManager()
    private let defaultCameraPosition = GMSCameraPosition(
        latitude: 59.93863,
        longitude: 30.31413,
        zoom: 12.0
    )
    private var circle: GMSCircle?

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
    
    private lazy var headerStackView: UIStackView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var allTabView: TabView = {
        $0.title = Localized.Tab.all
        $0.isActive = true
        $0.isHiddenCounter = true
        $0.addGestureRecognizer(allTabGestureRecognizer)
        return $0
    }(TabView())
    
    private lazy var personalTabView: TabView = {
        $0.title = Localized.Tab.personal
        $0.isActive = false
        $0.isHiddenCounter = false
        $0.addGestureRecognizer(personalTabGestureRecognizer)
        return $0
    }(TabView())
    
    // MARK: - Google Map
    
    private lazy var mapView: GMSMapView = {
        $0.camera = defaultCameraPosition
        $0.isMyLocationEnabled = false
        $0.settings.myLocationButton = false
        return $0
    }(GMSMapView())
    
    private var clusterManager: GMUClusterManager!
    
    // MARK: - Gesture Recognizer
    
    private lazy var allTabGestureRecognizer: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(handleAllTabTap))
        return $0
    }(UITapGestureRecognizer())
    
    private lazy var personalTabGestureRecognizer: UITapGestureRecognizer = {
        $0.addTarget(self, action: #selector(handlePersonalTabTap))
        return $0
    }(UITapGestureRecognizer())

    // MARK: - Managing the View
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.clear
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

    // MARK: - Setup

    private func setup() {
        navigationItem.title = "Квесты"
        tabBarItem.title = "Квесты"
        tabBarItem.image = UIImage.Styles.questsOutline
        tabBarItem.selectedImage = UIImage.Styles.questsOutline
    }

    private func setupView() {
        [
            headerView,
            mapView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            headerStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }
        
        [
            allTabView,
            personalTabView,
        ].forEach {
            headerStackView.addArrangedSubview($0)
        }
    }

    private func setupConstraints() {
        let viewTopAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            viewTopAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            viewTopAnchor = topLayoutGuide.bottomAnchor
        }
        let constraints = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: viewTopAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func handleAllTabTap() {
        guard allTabView.isActive == false else { return }
        
        mapView.clear()
        clusterManager.clearItems()
        mapView.animate(to: defaultCameraPosition)
        allTabView.isActive = true
        personalTabView.isActive = false
        output.changeQuestRequestType(
            .all,
            lat: mapView.camera.target.latitude,
            lon: mapView.camera.target.longitude
        )
    }
    
    @objc
    private func handlePersonalTabTap() {
        guard personalTabView.isActive == false else { return }
        
        mapView.clear()
        clusterManager.clearItems()
        mapView.animate(to: defaultCameraPosition)
        allTabView.isActive = false
        personalTabView.isActive = true
        output.changeQuestRequestType(
            .personal,
            lat: mapView.camera.target.latitude,
            lon: mapView.camera.target.longitude
        )
    }
}

// MARK: - ContentMapViewInput

extension ContentMapViewController: ContentMapViewInput {
    func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(
            mapView: mapView,
            clusterIconGenerator: iconGenerator
        )
        renderer.delegate = self
        clusterManager = GMUClusterManager(
            map: mapView,
            algorithm: algorithm,
            renderer: renderer
        )
        clusterManager.setDelegate(
            self,
            mapDelegate: self
        )
    }
    
    func setupQuests(
        _ quests: [Quest]
    ) {
        mapView.clear()
        clusterManager.clearItems()
        clusterManager.add(quests.map { QuestClusterItem(quest: $0) })
        clusterManager.cluster()
    }
}

// MARK: - ContentMapTransitionHandler

extension ContentMapViewController: ContentMapTransitionHandler { }

// MARK: - GMUClusterRendererDelegate

extension ContentMapViewController: GMUClusterRendererDelegate {
    func renderer(
        _ renderer: GMUClusterRenderer,
        markerFor object: Any
    ) -> GMSMarker? {
        switch object {
        case let clusterItem as QuestClusterItem:
            let marker = QuestMarker(quest: clusterItem.quest)
            marker.tracksViewChanges = false
            marker.tracksInfoWindowChanges = false
            return marker
        case let staticCluster as GMUStaticCluster:
            switch staticCluster.items.first {
            case let questClusterItem as QuestClusterItem:
                let marker = QuestsMarker(
                    quest: questClusterItem.quest,
                    count: Int(staticCluster.count)
                )
                marker.tracksViewChanges = false
                marker.tracksInfoWindowChanges = false
                return marker
            default:
                return nil
            }
        default:
            return nil
        }
    }
}

// MARK: - GMUClusterManagerDelegate

extension ContentMapViewController: GMSMapViewDelegate {
    func mapView(
        _ mapView: GMSMapView,
        didTap marker: GMSMarker
    ) -> Bool {
        switch marker.userData {
        case let questClusterItem as QuestClusterItem:
            output.didHandleQuest(questClusterItem.quest)
        default:
            return false
        }
        return true
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

// MARK: - GMUClusterManagerDelegate

extension ContentMapViewController: GMUClusterManagerDelegate {
    func clusterManager(
        _ clusterManager: GMUClusterManager,
        didTap cluster: GMUCluster
    ) -> Bool {
        let newCamera = GMSCameraPosition.camera(
            withTarget: cluster.position,
            zoom: mapView.camera.zoom + 1
        )
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return true
    }
}

// MARK: - Localization

private extension ContentMapViewController {
    enum Localized {
        // swiftlint:disable line_length
        enum Tab {
            static let all = NSLocalizedString(
                "ContentMapViewController.Tab.All",
                value: "Все",
                comment: "Title в табе `Все` на экране квестов"
            )
            static let sponsor = NSLocalizedString(
                "ContentMapViewController.Tab.Sponsor",
                value: "Спонсорские",
                comment: "Title в табе `Спонсорские` на экране квестов"
            )
            static let personal = NSLocalizedString(
                "ContentMapViewController.Tab.Personal",
                value: "Персональные",
                comment: "Title в табе `Персональные` на экране квестов"
            )
            static let quests = NSLocalizedString(
                "ContentMapViewController.Tab.Quests",
                value: "Квесты",
                comment: "Title в табе `Квесты` на экране квестов"
            )
        }
        // swiftlint:enable line_length
    }
}
