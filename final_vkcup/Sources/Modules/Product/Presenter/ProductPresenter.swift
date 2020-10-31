final class ProductPresenter {

    // MARK: - VIPER

    var interactor: ProductInteractorInput!
    var router: ProductRouterInput!

	weak var view: ProductViewInput?
    weak var outputData: ProductOutputData?
    
    // MARK: - Data
    
    private var productViewModel: BriefProductViewModel
    private let indexPath: IndexPath

    // MARK: - Init data

    init(
        productViewModel: BriefProductViewModel,
        ownerId: Int,
        indexPath: IndexPath
    ) {
        self.productViewModel = productViewModel
        self.indexPath = indexPath
    }
}

// MARK: - ProductViewOutput

extension ProductPresenter: ProductViewOutput {
	func setupView() {
        view?.setupViewModel(productViewModel)
        view?.setupIsFavorite(productViewModel.isFavorite)
    }
    
    func didPressBackButton() {
        router.close()
    }
    
    func didPressFavoriteButton() {
        view?.showActivityOverCurrentContext()
        outputData?.didHandleProduct(at: indexPath)
    }
}

// MARK: - ProductInteractorOutput

extension ProductPresenter: ProductInteractorOutput {
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

// MARK: - Localized

private extension ProductPresenter {
    enum Localized {
    // swiftlint:disable line_length
        enum Error {
            enum Common {
                static let title = NSLocalizedString(
                    "ProductPresenter.Error.Common.Title",
                    value: "Ошибка",
                    comment: "Title общей ошибки на экране Товара"
                )
                static let message = NSLocalizedString(
                    "ProductPresenter.Error.Common.Message",
                    value: "Что-то пошло не так",
                    comment: "Message общей ошибки на экране Товара"
                )
            }
            enum FailInitRequest {
                static let title = NSLocalizedString(
                    "ProductPresenter.Error.FailInitRequest.Title",
                    value: "Ошибка запроса",
                    comment: "Title ошибки создания запроса на экране Товара"
                )
                static let message = NSLocalizedString(
                    "ProductPresenter.Error.FailInitRequest.Message",
                    value: "Некорректный запрос",
                    comment: "Message ошибки создания запроса на экране Товара"
                )
            }
            enum FailParse {
                static let title = NSLocalizedString(
                    "ProductPresenter.Error.FailParse.Title",
                    value: "Ошибка данных",
                    comment: "Title ошибки парсинга данных на экране Товара"
                )
                static let message = NSLocalizedString(
                    "ProductPresenter.Error.FailParse.Message",
                    value: "Невозможно обработать данные",
                    comment: "Message ошибки парсинга данных на экране Товара"
                )
            }
        }
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension ProductPresenter {
    enum Constants { }
}
