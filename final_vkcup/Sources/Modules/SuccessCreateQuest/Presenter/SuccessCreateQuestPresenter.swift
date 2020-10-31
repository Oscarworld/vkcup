final class SuccessCreateQuestPresenter {

    // MARK: - VIPER

    var interactor: SuccessCreateQuestInteractorInput!
    var router: SuccessCreateQuestRouterInput!

	weak var view: SuccessCreateQuestViewInput?

    // MARK: - Init data

    init() { }
}

// MARK: - SuccessCreateQuestViewOutput

extension SuccessCreateQuestPresenter: SuccessCreateQuestViewOutput {
	func setupView() { }
}

// MARK: - SuccessCreateQuestInteractorOutput

extension SuccessCreateQuestPresenter: SuccessCreateQuestInteractorOutput { }

// MARK: - Localized

private extension SuccessCreateQuestPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SuccessCreateQuestPresenter {
    enum Constants { }
}