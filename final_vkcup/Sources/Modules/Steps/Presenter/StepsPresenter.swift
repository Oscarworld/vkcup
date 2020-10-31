import CoreLocation

final class StepsPresenter: NSObject {

    // MARK: - VIPER

    var interactor: StepsInteractorInput!
    var router: StepsRouterInput!

	weak var view: StepsViewInput?
    
    // MARK: - Data
    
    private var quest: Quest
    private var locations: [String] = []

    // MARK: - Init data

    init(quest: Quest) {
        self.quest = quest
    }
    
    // MARK: - Stored properties

    private let locationManager = CLLocationManager()
}

// MARK: - StepsViewOutput

extension StepsPresenter: StepsViewOutput {
	func setupView() {
        view?.showActivity()
        let group = DispatchGroup()
        locations = Array.init(repeating: "", count: quest.steps.count)
        
        for (offset, step) in quest.steps.enumerated() {
            let address = CLGeocoder()
            let location = CLLocation(
                latitude: step.lat,
                longitude: step.lon
            )
            group.enter()
            address.reverseGeocodeLocation(location) { [weak self] (places, error) in
                guard let self = self else { return }
                
                if error == nil && places?.count ?? 0 > 0 {
                    self.locations[offset] = [
                        places?[0].addressDictionary?["City"] as? String,
                        places?[0].name,
                    ].compactMap { $0 }.joined(separator: ", ")
                } else {
                    self.locations[offset] = "Не удалось распознать адрес"
                }
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.view?.hideActivity()
            self?.view?.reloadData()
        }
    }
    
    func numberOfSections() -> Int {
        return quest.steps.count
    }
    
    func numberOfItems(
        at section: Int
    ) -> Int {
        switch quest.steps[section].availableType {
        case .available:
            return 1
        default:
            return 0
        }
    }
    
    func getSectionViewModel(
        at section: Int
    ) -> SectionViewModel? {
        let title: String
        switch section {
        case 0:
            title = "Первое задание"
        case 1:
            title = "Второе задание"
        case 2:
            title = "Третье задание"
        default:
            title = "Задание №\(section)"
        }
        
        let image: UIImage?
        switch quest.steps[section].availableType {
        case .available:
            image = UIImage.Styles.chevronDownOutline
        case .completed:
            image = UIImage.Styles.doneOutline
        case .locked:
            image = UIImage.Styles.lockOutline
        }
        
        return SectionViewModel(
            title: title,
            image: image
        )
    }
    
    func getItemViewModel(
        at indexPath: IndexPath
    ) -> ItemViewModel? {
        let step = quest.steps[indexPath.section]
        
        let buttonTitle: String
        switch step.type {
        case .location:
            buttonTitle = "Отправить локацию"
        case .qr:
            buttonTitle = "Сканировать QR-код"
        case .question:
            buttonTitle = "Ответить"
        }
        
        return ItemViewModel(
            photoUrl: step.photo,
            title: step.title,
            description: step.description,
            location: locations[indexPath.section],
            buttonTitle: buttonTitle
        )
    }
    
    func didHandleStepButton(
        at indexPath: IndexPath
    ) {
        let step = quest.steps[indexPath.section]
        switch step.type {
        case .location:
            openSelectLocation(for: step)
        case let .question((question, _)):
            openQuestion(question: question)
        case .qr:
            openQRCodeScan(step: step)
        }
    }
    
    private func openQuestion(
        question: String
    ) {
        let alertController = UIAlertController(
            title: "Ответьте на вопрос",
            message: question,
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = "Введите ответ"
        }
        
        let submitAlert = UIAlertAction(
            title: "Ответить",
            style: .default
        ) { _ in
            self.checkSteps()
        }
        alertController.addAction(submitAlert)
        router.showAlertWithTextField(alertController: alertController)
    }
    
    private func openQRCodeScan(
        step: QuestStep
    ) {
        router.openQRCodeScan(moduleOutput: self)
    }
    
    private func openSelectLocation(
        for step: QuestStep
    ) {
        let selectLocationAction = UIAlertAction(
            title: "Выбрать на карте",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }

            self.router.openSelectLocation(moduleOutput: self)
        }

        let selectMyLocationAction = UIAlertAction(
            title: "Отправить свою локацию",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }

            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                if self.locationManager.location != nil {
                    self.checkSteps()
                }
            }
        }

        let cancelAction = UIAlertAction(
            title: "Отменить",
            style: .cancel
        )

        router.showActionSheetView(
            title: nil,
            message: "Выберите способ отправки локации",
            actions: [
                selectLocationAction,
                selectMyLocationAction,
                cancelAction,
            ]
        )
    }
    
    private func successfulCompletionQuest() {
        let inputData = SuccessScreenModuleInput(gift: quest.gifts[0])
        router.openSuccessScreen(inputData: inputData)
    }
    
    private func checkSteps() {
        if quest.steps.filter({ $0.availableType == .completed }).count == quest.steps.count - 1 {
            successfulCompletionQuest()
        } else {
            if let stepIndex = quest.steps.firstIndex(where: { $0.availableType == .available }) {
                quest.steps[stepIndex].availableType = .completed
                quest.steps[stepIndex + 1].availableType = .available
                view?.reloadData()
            }
        }
    }
}

// MARK: - StepsInteractorOutput

extension StepsPresenter: StepsInteractorOutput { }

// MARK: - CLLocationManagerDelegate

extension StepsPresenter: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if locationManager.location != nil {
                checkSteps()
            }
        } else {
            print("Error get location")
        }
    }
}

// MARK: - AddQuestStepLocationModuleOutput

extension StepsPresenter: AddQuestStepLocationModuleOutput {
    func didSelectLocation(
        address: String,
        lat: Double,
        lon: Double
    ) {
        router.closeOpenSelectLocation { [weak self] in
            self?.checkSteps()
        }
    }
}

// MARK: - QRCodeScanModuleOutput

extension StepsPresenter: QRCodeScanModuleOutput {
    func didScanQRCode(url: String?) {
        router.closeOpenSelectLocation { [weak self] in
            self?.checkSteps()
        }
    }
}

// MARK: - Localized

private extension StepsPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension StepsPresenter {
    enum Constants { }
}
