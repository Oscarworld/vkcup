protocol ProductService {
    func cancelAllOperations()
    
    func getProducts(
        ownerId: Int,
        offset: Int,
        count: Int,
        completion: @escaping (Result<(products: [Product], count: Int), ServiceError>) -> Void
    )
    
    func addToFavorite(
        ownerId: Int,
        productId: Int,
        completion: @escaping (Result<Void, ServiceError>) -> Void
    )
    
    func removeFromFavorite(
        ownerId: Int,
        productId: Int,
        completion: @escaping (Result<Void, ServiceError>) -> Void
    )
}
