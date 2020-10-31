final class AddMoneyPresenter {

    // MARK: - VIPER

    var interactor: AddMoneyInteractorInput!
    var router: AddMoneyRouterInput!

	weak var view: AddMoneyViewInput?
    weak var moduleOutput: AddMoneyModuleOutput?
    
    // MARK: - Data
    
    private let viewModels: [SelectViewModel] = [
        SelectViewModel(id: 0, title: "VK Pay"),
        SelectViewModel(id: 1, title: "Mastercard •••• 1454"),
        SelectViewModel(id: 1, title: "Mastercard •••• 4432"),
        SelectViewModel(id: 1, title: "VISA •••• 6784"),
        SelectViewModel(id: 1, title: "Мир •••• 8035"),
    ]
    private var selected = SelectViewModel(id: 0, title: "VK Pay")

    // MARK: - Init data

    init() { }
}

// MARK: - AddMoneyViewOutput

extension AddMoneyPresenter: AddMoneyViewOutput {
	func setupView() {
        view?.reloadData()
    }
    
    func didHandleAddMoney(
        value: String
    ) {
        moduleOutput?.didSelect(
            selected,
            value: value
        )
    }
    
    func numberOfItems() -> Int {
        return viewModels.count
    }
    
    func getViewModel(
        in indexPath: IndexPath
    ) -> SelectViewModel? {
        guard indexPath.row < viewModels.count else {
            assertionFailure("ViewModel should be at \(indexPath)")
            return nil
        }
        
        return viewModels[indexPath.row]
    }
    
    func getSelectedViewModel() -> SelectViewModel? {
        return selected
    }
    
    func didSelectCell(
        at indexPath: IndexPath
    ) {
        guard indexPath.row < viewModels.count else {
            assertionFailure("ViewModel should be at \(indexPath)")
            return
        }
        
        selected = viewModels[indexPath.row]
        view?.reloadData()
    }
}

// MARK: - AddMoneyInteractorOutput

extension AddMoneyPresenter: AddMoneyInteractorOutput {}

// MARK: - Localized

private extension AddMoneyPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddMoneyPresenter {
    enum Constants { }
}
