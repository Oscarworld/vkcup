final class MarketPresenter {

    // MARK: - VIPER

    var interactor: MarketInteractorInput!
    var router: MarketRouterInput!

	weak var view: MarketViewInput?
    weak var outputData: MarketModuleOutpudData?
    
    // MARK: - Data
    
    private let groupId: Int
    private let groupTitle: String
    
    // MARK: - Data
    
    private let productViewModelFactory: ProductViewModelFactory

    // MARK: - Init data

    init(
        groupId: Int,
        groupTitle: String,
        productViewModelFactory: ProductViewModelFactory
    ) {
        self.groupId = groupId
        self.groupTitle = groupTitle
        self.productViewModelFactory = productViewModelFactory
    }
    
    // MARK: - Placeholder state
    
    var placeholderState: ProductsPlaceholderState? {
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
    private var productsCount: Int = 0
    private var offset: Int = 0
    private var productViewModels: [BriefProductViewModel] = []
    private var heightLines: [CGFloat] = []
}

// MARK: - MarketViewOutput

extension MarketPresenter: MarketViewOutput {
	func setupView() {
        guard let view = view else { return }
        
        view.setupTitle(groupTitle: groupTitle)
        view.showActivity()
        fetchProducts(context: .initial)
    }
    
    func didPressBackButton() {
        router.close()
    }
    
    func numberOfItems() -> Int {
        return productViewModels.count
    }
    
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefProductViewModel? {
        guard indexPath.row < productViewModels.count else {
             assertionFailure("ViewModel should be at \(indexPath)")
             return nil
         }
         
         return productViewModels[indexPath.row]
    }
    
    func getViewModels(
        in line: Int,
        numberRowInLine: Int
    ) -> [BriefProductViewModel] {
        let count = productViewModels.count
        let startIndex = line * numberRowInLine
        
        guard startIndex < count else { return [] }
        let endIndex = min(count, startIndex + numberRowInLine)
        
        return Array(productViewModels[startIndex ..< endIndex])
    }
    
    func didSelectItem(
        at indexPath: IndexPath
    ) {
        guard indexPath.row < productViewModels.count else {
             assertionFailure("ViewModel should be at \(indexPath)")
             return
         }
        
        let inputData = ProductInputData(
            viewModel: productViewModels[indexPath.row],
            ownerId: groupId,
            indexPath: indexPath
        )
        router.openProduct(
            inputData: inputData,
            outputData: self
        )
    }
    
    func didPressReload() {
        placeholderState = nil
        view?.showActivity()
        fetchProducts(context: .reload)
    }
    
    func refreshDidPull() {
        fetchProducts(context: .reload)
    }
    
    func didScrollToBottom() {
        guard case .idle = loadingState else { return }
        
        fetchProducts(context: .pagination)
    }
    
    private func fetchProducts(
        context: ProductsInteractorUpdatingContext
    ) {
        switch context {
        case .initial, .reload:
            offset = 0
        case .pagination:
            if offset == productsCount {
                return
            }
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.loadingState = .loading
            self.interactor.getProducts(
                ownerId: self.groupId,
                offset: self.offset,
                count: Constants.requestProductsCount,
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
        
        router.showAlert(
            title: title,
            message: message
        )
    }
}

// MARK: - MarketInteractorOutput

extension MarketPresenter: MarketInteractorOutput {
    func didFetchProducts(
        count: Int,
        products: [Product],
        context: ProductsInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            self.productsCount = count
            
            let productViewModels = self.productViewModelFactory.makeProductViewModels(products)
            
            switch context {
            case .initial, .reload:
                self.heightLines = []
                self.offset = min(products.count, count)
                self.productViewModels = productViewModels
                if productViewModels.isEmpty {
                    self.placeholderState = .emptyList
                } else {
                    self.placeholderState = nil
                    view.reloadData()
                }
                
            case .pagination:
                self.offset = min(self.offset + products.count, count)
                let indexPaths = self.makeIndexPathsToAppend(productViewModels)
                self.productViewModels += productViewModels
                view.appendViewModels(indexPaths)
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    func didFailFetchProducts(
        _ error: ServiceError,
        context: ProductsInteractorUpdatingContext
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            switch context {
            case .initial:
                self.placeholderState = .failFetchProducts
            case .reload, .pagination:
                self.showError(error)
            }
            
            self.hideActivity(in: view)
            self.loadingState = .idle
        }
    }
    
    private func hideActivity(in view: MarketViewInput) {
        view.hideActivity()
        view.endRefreshing()
        view.hideActivityOverCurrentContext()
    }
    
    private func makeIndexPathsToAppend(
        _ productViewModels: [BriefProductViewModel]
    ) -> [IndexPath] {
        let previousViewCount = self.productViewModels.count
        let newCount = self.productViewModels.count + productViewModels.count

        var indexPaths: [IndexPath] = []

        (previousViewCount..<newCount).forEach {
            let indexPath = IndexPath(row: $0, section: 0)
            indexPaths.append(indexPath)
        }

        return indexPaths
    }
}

// MARK: - ProductOutputData

extension MarketPresenter: ProductOutputData {
    func didHandleProduct(
        at indexPath: IndexPath
    ) {
        guard indexPath.row < productViewModels.count else {
            assertionFailure("ViewModel should be at \(indexPath)")
            return
        }
        
        let product = productViewModels[indexPath.row]
        outputData?.didSelectProduct(product)
    }
}

// MARK: - Localized

private extension MarketPresenter {
    enum Localized {
    // swiftlint:disable line_length
        enum Error {
            enum Common {
                static let title = NSLocalizedString(
                    "MarketPresenter.Error.Common.Title",
                    value: "Ошибка",
                    comment: "Title общей ошибки на экране Товаров"
                )
                static let message = NSLocalizedString(
                    "MarketPresenter.Error.Common.Message",
                    value: "Что-то пошло не так",
                    comment: "Message общей ошибки на экране Товаров"
                )
            }
            enum FailInitRequest {
                static let title = NSLocalizedString(
                    "MarketPresenter.Error.FailInitRequest.Title",
                    value: "Ошибка запроса",
                    comment: "Title ошибки создания запроса на экране Товаров"
                )
                static let message = NSLocalizedString(
                    "MarketPresenter.Error.FailInitRequest.Message",
                    value: "Некорректный запрос",
                    comment: "Message ошибки создания запроса на экране Товаров"
                )
            }
            enum FailParse {
                static let title = NSLocalizedString(
                    "MarketPresenter.Error.FailParse.Title",
                    value: "Ошибка данных",
                    comment: "Title ошибки парсинга данных на экране Товаров"
                )
                static let message = NSLocalizedString(
                    "MarketPresenter.Error.FailParse.Message",
                    value: "Невозможно обработать данные",
                    comment: "Message ошибки парсинга данных на экране Товаров"
                )
            }
        }
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension MarketPresenter {
    enum Constants {
        static let requestProductsCount: Int = 10
    }
}
