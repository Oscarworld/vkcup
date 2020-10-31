//import CoreLocation

final class SponsorQuestDetailsPresenter: NSObject {

    // MARK: - VIPER

    var interactor: SponsorQuestDetailsInteractorInput!
    var router: SponsorQuestDetailsRouterInput!

	weak var view: SponsorQuestDetailsViewInput?
    
    // MARK: - Data
    
    private let quest: Quest
    private let location: String

    // MARK: - Init data

    init(
        quest: Quest,
        location: String
    ) {
        self.quest = quest
        self.location = location
    }
}

// MARK: - SponsorQuestDetailsViewOutput

extension SponsorQuestDetailsPresenter: SponsorQuestDetailsViewOutput {
	func setupView() {
        view?.setupQuest(
            quest,
            location: location
        )
    }
    
    func didHandleSubmitButton() {
        let inputData = StepsModuleInput(quest: quest)
        router.openSteps(inputData: inputData)
    }
}

// MARK: - SponsorQuestDetailsInteractorOutput

extension SponsorQuestDetailsPresenter: SponsorQuestDetailsInteractorOutput { }

// MARK: - Localized

private extension SponsorQuestDetailsPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SponsorQuestDetailsPresenter {
    enum Constants { }
}
