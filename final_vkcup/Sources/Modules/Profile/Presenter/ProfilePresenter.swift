final class ProfilePresenter {

    // MARK: - VIPER

    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!

	weak var view: ProfileViewInput?

    // MARK: - Init data

    init() { }
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
	func setupView() { }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput { }

// MARK: - Localized

private extension ProfilePresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension ProfilePresenter {
    enum Constants { }
}