final class SelectActionSheetPresenter {

    // MARK: - VIPER

    var router: SelectActionSheetRouterInput!

	weak var view: SelectActionSheetViewInput?
    weak var moduleOutput: SelectActionSheetOutput?
    
    // MARK: - Data
    
    private let title: String
    private let viewModels: [SelectViewModel]
    private let selected: SelectViewModel?

    // MARK: - Init data

    init(
        title: String,
        viewModels: [SelectViewModel],
        selected: SelectViewModel?
    ) {
        self.title = title
        self.viewModels = viewModels
        self.selected = selected
    }
}

// MARK: - SelectActionSheetViewOutput

extension SelectActionSheetPresenter: SelectActionSheetViewOutput {
    func setupView() {
        view?.setupTitle(title)
        view?.reloadData()
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
            router.close()
            return
        }
        
        moduleOutput?.didSelect(
            viewModels[indexPath.row],
            in: self
        )
        router.close()
    }
    
    func didPressCloseButton() {
        router.close()
    }
}

// MARK: - SelectActionSheetInput

extension SelectActionSheetPresenter: SelectActionSheetInput {}
