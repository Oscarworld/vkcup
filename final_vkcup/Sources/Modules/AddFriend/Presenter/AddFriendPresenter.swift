final class AddFriendPresenter {

    // MARK: - VIPER

    var interactor: AddFriendInteractorInput!
    var router: AddFriendRouterInput!

	weak var view: AddFriendViewInput?
    weak var moduleOutput: AddFriendModuleOutput?
    
    // MARK: - Data
    
    private let friendsViewModelFactory: FriendsViewModelFactory

    // MARK: - Init data

    init(
        friendsViewModelFactory: FriendsViewModelFactory
    ) {
        self.friendsViewModelFactory = friendsViewModelFactory
    }
    
    // MARK: - Placeholder state
    
    var placeholderState: AddFriendPlaceholderState? {
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
    private var friendsCount: Int = 0
    private var offset: Int = 0
    private var friendsViewModels: [BriefGroupViewModel] = []
}

// MARK: - AddFriendViewOutput

extension AddFriendPresenter: AddFriendViewOutput {
	func setupView() {
        guard let view = view else { return }
        
        view.showActivity()
        fetchFriends(context: .initial)
    }
    
    func numberOfItems() -> Int {
        return friendsViewModels.count
    }
    
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefGroupViewModel? {
        guard indexPath.row < friendsViewModels.count else {
            assertionFailure("GroupViewModels should be at \(indexPath)")
            return nil
        }
        
        return friendsViewModels[indexPath.row]
    }
    
    func didSelectCell(
        at indexPath: IndexPath
    ) {
        guard indexPath.row < friendsViewModels.count else {
            assertionFailure("GroupViewModels should be at \(indexPath)")
            return
        }
        
        let friend = friendsViewModels[indexPath.row]
        moduleOutput?.didAddFriend(friend)
    }
    
    func didPressReload() {
        fetchFriends(context: .reload)
    }
    
    func refreshDidPull() {
        fetchFriends(context: .reload)
    }
    
    func didScrollToBottom() {
        guard case .idle = loadingState else { return }
        
        view?.showPaginationActivity()
        fetchFriends(context: .pagination)
    }
    
    private func fetchFriends(context: AddFriendInteractorUpdatingContext) {
        switch context {
        case .initial, .reload:
            offset = 0
        case .pagination:
            if offset == friendsCount {
                return
            }
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.loadingState = .loading
            self.interactor.getFriends(
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

// MARK: - AddFriendInteractorOutput

extension AddFriendPresenter: AddFriendInteractorOutput {
    func didFetchFriends(
        count: Int,
        friends: [Friend],
        context: AddFriendInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            self.friendsCount = count
            
            let friendsViewModels = self.friendsViewModelFactory.makeFriendsViewModels(friends)
            
            switch context {
            case .initial, .reload:
                self.offset = min(friends.count, count)
                self.friendsViewModels = friendsViewModels
                if friendsViewModels.isEmpty {
                    self.placeholderState = .emptyList
                } else {
                    self.placeholderState = nil
                    view.reloadData()
                }
                
            case .pagination:
                self.offset = min(self.offset + friends.count, count)
                let indexPaths = self.makeIndexPathsToAppend(friendsViewModels)
                self.friendsViewModels += friendsViewModels
                view.insertItems(indexPaths)
            }
            
            if self.offset == self.friendsCount {
                view.hidePagination(forced: true)
            } else {
                view.hidePagination(forced: false)
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    func didFailFetchFriends(
        _ error: ServiceError,
        context: AddFriendInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            switch context {
            case .initial:
                self.placeholderState = .failFetchFriends
            case .reload:
                self.showError(error)
            case .pagination:
                view.showPaginationError()
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    private func hideActivity(in view: AddFriendViewInput) {
        view.hideActivity()
        view.endRefreshing()
        view.hideActivityOverCurrentContext()
    }
    
    private func makeIndexPathsToAppend(
        _ friendsViewModels: [BriefGroupViewModel]
    ) -> [IndexPath] {
        let previousViewCount = self.friendsViewModels.count
        let newCount = self.friendsViewModels.count + friendsViewModels.count

        var indexPaths: [IndexPath] = []

        (previousViewCount..<newCount).forEach {
            let indexPath = IndexPath(row: $0, section: 0)
            indexPaths.append(indexPath)
        }

        return indexPaths
    }
}

// MARK: - Localized

private extension AddFriendPresenter {
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

private extension AddFriendPresenter {
    enum Constants {
        static let requestGroupsCount: Int = 10
    }
}
