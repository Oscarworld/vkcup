final class MarketInteractor {

    // MARK: - VIPER

    weak var output: MarketInteractorOutput?

    // MARK: - Data
    
    private let productService: ProductService

    // MARK: - Init

	init(productService: ProductService) {
        self.productService = productService
    }
}

// MARK: - MarketInteractorInput

extension MarketInteractor: MarketInteractorInput {
    func cancelAllOperations() {
        productService.cancelAllOperations()
    }
    
    func getProducts(
        ownerId: Int,
        offset: Int,
        count: Int,
        context: ProductsInteractorUpdatingContext
    ) {
        productService.getProducts(
            ownerId: ownerId,
            offset: offset,
            count: count
        ) { [weak self] result in
            guard let output = self?.output else { return }
            
            switch result {
            case .success(let result):
                output.didFetchProducts(
                    count: result.count,
                    products: result.products,
                    context: context
                )
            case .failure(let error):
                output.didFailFetchProducts(
                    error,
                    context: context
                )
            }
        }
    }
}
