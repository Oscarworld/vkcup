final class SuccessScreenPresenter {

    // MARK: - VIPER

    var interactor: SuccessScreenInteractorInput!
    var router: SuccessScreenRouterInput!

	weak var view: SuccessScreenViewInput?
    
    // MARK: - Data
    
    private let gift: QuestGift

    // MARK: - Init data

    init(gift: QuestGift) {
        self.gift = gift
    }
}

// MARK: - SuccessScreenViewOutput

extension SuccessScreenPresenter: SuccessScreenViewOutput {
	func setupView() {
        view?.setupGift(gift)
    }
    
    func viewDidAppear() {
        view?.runConfetti()
    }
}

// MARK: - SuccessScreenInteractorOutput

extension SuccessScreenPresenter: SuccessScreenInteractorOutput { }

// MARK: - Localized

private extension SuccessScreenPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SuccessScreenPresenter {
    enum Constants { }
}
