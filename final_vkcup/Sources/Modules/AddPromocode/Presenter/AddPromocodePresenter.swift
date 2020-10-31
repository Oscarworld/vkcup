final class AddPromocodePresenter {

    // MARK: - VIPER

    var interactor: AddPromocodeInteractorInput!
    var router: AddPromocodeRouterInput!

	weak var view: AddPromocodeViewInput?
    weak var moduleOutput: AddPromocodeModuleOutput?

    // MARK: - Init data

    init() { }
}

// MARK: - AddPromocodeViewOutput

extension AddPromocodePresenter: AddPromocodeViewOutput {
	func setupView() { }
    
    func didHandleAddPromocode(
        title: String,
        description: String,
        value: String
    ) {
        let promocode = PromocodeViewModel(
            id: 0,
            title: title,
            description: description,
            value: value
        )
        moduleOutput?.didAddPromocode(promocode)
    }
}

// MARK: - AddPromocodeInteractorOutput

extension AddPromocodePresenter: AddPromocodeInteractorOutput { }

// MARK: - Localized

private extension AddPromocodePresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddPromocodePresenter {
    enum Constants { }
}
