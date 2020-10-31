final class ProductInteractor {

    // MARK: - VIPER

    weak var output: ProductInteractorOutput?

    // MARK: - Data

    // MARK: - Init

    init() {}
}

// MARK: - ProductInteractorInput

extension ProductInteractor: ProductInteractorInput {}
