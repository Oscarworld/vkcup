import CoreLocation

final class AddQuestStepLocationPresenter {

    // MARK: - VIPER

    var interactor: AddQuestStepLocationInteractorInput!
    var router: AddQuestStepLocationRouterInput!

	weak var view: AddQuestStepLocationViewInput?
    weak var moduleOutput: AddQuestStepLocationModuleOutput?

    // MARK: - Init data

    init() { }
    
    // MARK: - Stored data
    
    private var timer: Timer?
}

// MARK: - AddQuestStepLocationViewOutput

extension AddQuestStepLocationPresenter: AddQuestStepLocationViewOutput {
	func setupView() { }
    
    func moveCamera(
        lat: Double,
        lon: Double
    ) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.3,
            repeats: false,
            block: { [weak self] _ in
                guard let self = self else { return }
                let address = CLGeocoder()
                let location = CLLocation(
                    latitude: lat,
                    longitude: lon
                )
                address.reverseGeocodeLocation(location) { [weak self] (places, error) in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self,
                              let view = self.view else { return }
                        
                        let address: String
                        if error == nil && places?.count ?? 0 > 0 {
                            address = [
                                places?[0].addressDictionary?["City"] as? String,
                                places?[0].name,
                            ].compactMap { $0 }
                            .joined(separator: ", ")
                        } else {
                            address = "Невозможно определить адрес"
                        }
                        view.setupAddress(address)
                    }
                }
        })
    }
    
    func didHandleSelectLocation(
        address: String,
        lat: Double,
        lon: Double
    ) {
        moduleOutput?.didSelectLocation(
            address: address,
            lat: lat,
            lon: lon
        )
    }
}

// MARK: - AddQuestStepLocationInteractorOutput

extension AddQuestStepLocationPresenter: AddQuestStepLocationInteractorOutput { }

// MARK: - Localized

private extension AddQuestStepLocationPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddQuestStepLocationPresenter {
    enum Constants { }
}
