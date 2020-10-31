final class GroupsPresenter {

    // MARK: - VIPER

    var interactor: GroupsInteractorInput!
    var router: GroupsRouterInput!

	weak var view: GroupsViewInput?
    weak var outputData: GroupsModuleOutputData?
    
    // MARK: - Data
    
    private let groupViewModelFactory: GroupViewModelFactory
    private let cityViewModelFactory: CityViewModelFactory

    // MARK: - Init

    init(
        groupViewModelFactory: GroupViewModelFactory,
        cityViewModelFactory: CityViewModelFactory
    ) {
        self.groupViewModelFactory = groupViewModelFactory
        self.cityViewModelFactory = cityViewModelFactory
    }
    
    // MARK: - Placeholder state
    
    var placeholderState: GroupsPlaceholderState? {
        didSet {
            if let state = placeholderState {
                view?.showPlaceholder(state)
            } else {
                view?.hidePlaceholder()
            }
        }
    }
    
    // MARK: - Stored data
    
    enum LoadingState {
        case idle
        case loading
    }
    
    private var loadingState: LoadingState = .idle
    private var groupsCount: Int = 0
    private var offset: Int = 0
    private var groupViewModels: [BriefGroupViewModel] = []
    private var cityViewModels: [SelectViewModel] = []
    private var selectedCity: SelectViewModel?
}

// MARK: - GroupsViewOutput

extension GroupsPresenter: GroupsViewOutput {
	func setupView() {
        guard let view = view else { return }
        
        view.showActivity()
        fetchCities()
    }
    
    func numberOfItems() -> Int {
        return groupViewModels.count
    }
    
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefGroupViewModel? {
        guard indexPath.row < groupViewModels.count else {
            assertionFailure("GroupViewModels should be at \(indexPath)")
            return nil
        }
        
        return groupViewModels[indexPath.row]
    }
    
    func didSelectCell(
        at indexPath: IndexPath
    ) {
        guard indexPath.row < groupViewModels.count else {
            assertionFailure("GroupViewModels should be at \(indexPath)")
            return
        }
        
        let groupViewModel = groupViewModels[indexPath.row]
        let inputData = MarketInputData(
            groupId: groupViewModel.id,
            groupTitle: groupViewModel.title
        )
        router.openGroup(
            inputData: inputData,
            outputData: self
        )
    }
    
    func didPressCities() {
        guard let selectedCity = self.selectedCity else { return }
        
        let inputData = SelectActionSheetInputData(
            title: "Город",
            viewModels: self.cityViewModels,
            selected: selectedCity
        )
        router.openCitySelector(
            inputData: inputData,
            moduleOutput: self
        )
    }
    
    func didPressReload() {
        fetchGroups(context: .reload)
    }
    
    func didPressReloadCities() {
        view?.showActivity()
        fetchCities()
    }
    
    func refreshDidPull() {
        fetchGroups(context: .reload)
    }
    
    func didScrollToBottom() {
        guard case .idle = loadingState else { return }
        
        view?.showPaginationActivity()
        fetchGroups(context: .pagination)
    }
    
    private func fetchCities() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.interactor.getCities()
        }
    }
    
    private func fetchGroups(
        context: GroupsInteractorUpdatingContext
    ) {
        switch context {
        case .initial, .reload:
            offset = 0
        case .pagination:
            if offset == groupsCount {
                return
            }
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let selectedCity = self.selectedCity else { return }
            
            self.loadingState = .loading
            self.interactor.getGroups(
                cityId: selectedCity.id,
                count: Constants.requestGroupsCount,
                offset: self.offset,
                context: context
            )
        }
    }
    
    private func showError(
        _ error: ServiceError
    ) {
        let title: String
        let message: String
        switch error {
        case ServiceError.failInitRequest:
            title = Localized.Error.FailInitRequest.title
            message = Localized.Error.FailInitRequest.message
        case ServiceError.failParse:
            title = Localized.Error.FailParse.title
            message = Localized.Error.FailParse.message
        case ServiceError.fail:
            title = Localized.Error.Common.title
            message = Localized.Error.Common.message
        }
        
        let actions = [
            UIAlertAction.okAction
        ]
        router.showAlert(
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .alert
        )
    }
}

// MARK: - MarketModuleOutpudData

extension GroupsPresenter: MarketModuleOutpudData {
    func didSelectProduct(_ product: BriefProductViewModel) {
        router.closeGroup()
        outputData?.didSelectProduct(product)
    }
}

// MARK: - GroupsInteractorOutput

extension GroupsPresenter: GroupsInteractorOutput {
    func didFetchCities(
        _ cities: [City]
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.cityViewModels = self.cityViewModelFactory.makeCityViewModels(cities)
            self.selectedCity = self.cityViewModels.first
            self.view?.setupCityTitle(self.selectedCity?.title ?? "")
            self.fetchGroups(context: .initial)
        }
    }
    
    func didFailFetchCities(
        _ error: ServiceError
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            self.hideActivity(in: view)
            self.placeholderState = .failFetchCities
            self.showError(error)
        }
    }
    
    func didFetchGroups(
        count: Int,
        groups: [VKGroup],
        context: GroupsInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            self.groupsCount = count
            
            let groupViewModels = self.groupViewModelFactory.makeGroupViewModels(groups)
            
            switch context {
            case .initial, .reload:
                self.offset = min(groups.count, count)
                self.groupViewModels = groupViewModels
                if groupViewModels.isEmpty {
                    self.placeholderState = .emptyList
                } else {
                    self.placeholderState = nil
                    view.reloadData()
                }
                
            case .pagination:
                self.offset = min(self.offset + groups.count, count)
                let indexPaths = self.makeIndexPathsToAppend(groupViewModels)
                self.groupViewModels += groupViewModels
                view.insertItems(indexPaths)
            }
            
            if self.offset == self.groupsCount {
                view.hidePagination(forced: true)
            } else {
                view.hidePagination(forced: false)
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    func didFailFetchGroups(
        _ error: ServiceError,
        context: GroupsInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            switch context {
            case .initial:
                self.placeholderState = .failFetchGroups
            case .reload:
                self.showError(error)
            case .pagination:
                view.showPaginationError()
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    private func hideActivity(in view: GroupsViewInput) {
        view.hideActivity()
        view.endRefreshing()
        view.hideActivityOverCurrentContext()
    }
    
    private func makeIndexPathsToAppend(
        _ groupViewModels: [BriefGroupViewModel]
    ) -> [IndexPath] {
        let previousViewCount = self.groupViewModels.count
        let newCount = self.groupViewModels.count + groupViewModels.count

        var indexPaths: [IndexPath] = []

        (previousViewCount..<newCount).forEach {
            let indexPath = IndexPath(row: $0, section: 0)
            indexPaths.append(indexPath)
        }

        return indexPaths
    }
}

// MARK: - CitiesActionSheetOutputData

extension GroupsPresenter: SelectActionSheetOutput {
    func didSelect(
        _ item: SelectViewModel,
        in moduleInput: SelectActionSheetInput
    ) {
        self.selectedCity = item
        view?.setupCityTitle(item.title)
        view?.showActivityOverCurrentContext()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.fetchGroups(context: .initial)
        }
    }
}

// MARK: - Localized

private extension GroupsPresenter {
    enum Localized {
        // swiftlint:disable line_length
        enum Error {
            enum Common {
                static let title = NSLocalizedString(
                    "GroupsPresenter.Error.Common.Title",
                    value: "Ошибка",
                    comment: "Title общей ошибки на экране Групп"
                )
                static let message = NSLocalizedString(
                    "GroupsPresenter.Error.Common.Message",
                    value: "Что-то пошло не так",
                    comment: "Message общей ошибки на экране Групп"
                )
            }
            enum FailInitRequest {
                static let title = NSLocalizedString(
                    "GroupsPresenter.Error.FailInitRequest.Title",
                    value: "Ошибка запроса",
                    comment: "Title ошибки создания запроса на экране Групп"
                )
                static let message = NSLocalizedString(
                    "GroupsPresenter.Error.FailInitRequest.Message",
                    value: "Некорректный запрос",
                    comment: "Message ошибки создания запроса на экране Групп"
                )
            }
            enum FailParse {
                static let title = NSLocalizedString(
                    "GroupsPresenter.Error.FailParse.Title",
                    value: "Ошибка данных",
                    comment: "Title ошибки парсинга данных на экране Групп"
                )
                static let message = NSLocalizedString(
                    "GroupsPresenter.Error.FailParse.Message",
                    value: "Невозможно обработать данные",
                    comment: "Message ошибки парсинга данных на экране Групп"
                )
            }
        }
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension GroupsPresenter {
    enum Constants {
        static let requestGroupsCount: Int = 10
    }
}
