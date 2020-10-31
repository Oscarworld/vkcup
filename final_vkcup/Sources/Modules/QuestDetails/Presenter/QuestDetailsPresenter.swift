import CoreLocation
import MapKit

final class QuestDetailsPresenter {

    // MARK: - VIPER

    var interactor: QuestDetailsInteractorInput!
    var router: QuestDetailsRouterInput!

	weak var view: QuestDetailsViewInput?
    weak var output: QuestDetailsModuleOutput?
    
    // MARK: - Data
    
    private let quest: Quest
    private var location: String = ""

    // MARK: - Init data

    init(quest: Quest) {
        self.quest = quest
    }
}

// MARK: - QuestDetailsViewOutput

extension QuestDetailsPresenter: QuestDetailsViewOutput {
	func setupView() {
        view?.showActivity()
        let buttonTitle: String
        switch quest.type {
        case .sponsor(.onlyForMembers):
            buttonTitle = "Подписаться на \(quest.owner)"
        case .quest:
            buttonTitle = "Зарегистрироваться"
        default:
            buttonTitle = "Открыть"
        }
        view?.setupButtonTitle(buttonTitle)
        let address = CLGeocoder()
        let location = CLLocation(
            latitude: quest.steps[0].lat,
            longitude: quest.steps[0].lon
        )
        address.reverseGeocodeLocation(location) { [weak self] (places, error) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      let view = self.view else { return }
                
                if error == nil && places?.count ?? 0 > 0 {
                    self.location = [
                        places?[0].addressDictionary?["City"] as? String,
                        places?[0].name,
                    ].compactMap { $0 }
                    .joined(separator: ", ")
                } else {
                    self.location = "Нет локации"
                }
                let availableGifts = self.quest.gifts.map { $0.available }.reduce(0, +)
                
                view.hideActivity()
                view.setViewModel(
                    title: self.quest.title,
                    description: self.quest.description,
                    location: self.location,
                    owner: self.quest.owner,
                    gifts: "\(self.getLeftGiftString(availableGifts)) \(availableGifts) \(self.getAvailableGiftString(availableGifts))"
                )
            }
        }
    }
    
    func didPressOpenButton() {
        router.close()
        output?.didHandleOpenQuest(
            quest,
            location: location
        )
    }
    
    func didPressCloseButton() {
        router.close()
    }
    
    private func getLeftGiftString(
        _ count: Int
    ) -> String {
        let count = count % 100
        
        if count >= 11 && count <= 19 {
            return "Осталось"
        } else {
            let i = count % 10
            switch i {
            case 1:
                return "Остался"
            case 2, 3, 4:
                return "Осталось"
            default:
                return "Осталось"
            }
        }
    }
    private func getAvailableGiftString(
        _ count: Int
    ) -> String {
        let count = count % 100
        
        if count >= 11 && count <= 19 {
            return "призов"
        } else {
            let i = count % 10
            switch i {
            case 1:
                return "приз"
            case 2, 3, 4:
                return "приза"
            default:
                return "призов"
            }
        }
    }
}

// MARK: - QuestDetailsInteractorOutput

extension QuestDetailsPresenter: QuestDetailsInteractorOutput { }

// MARK: - Localized

private extension QuestDetailsPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QuestDetailsPresenter {
    enum Constants { }
}
