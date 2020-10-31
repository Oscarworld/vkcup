enum ProductsInteractorUpdatingContext {
    case initial
    case pagination
    case reload
}

/// Market interactor input
protocol MarketInteractorInput {
    func cancelAllOperations()
    
    func getProducts(
        ownerId: Int,
        offset: Int,
        count: Int,
        context: ProductsInteractorUpdatingContext
    )
}

/// Market interactor output
protocol MarketInteractorOutput: class {
    func didFetchProducts(
        count: Int,
        products: [Product],
        context: ProductsInteractorUpdatingContext
    )
    
    func didFailFetchProducts(
        _ error: ServiceError,
        context: ProductsInteractorUpdatingContext
    )
}
