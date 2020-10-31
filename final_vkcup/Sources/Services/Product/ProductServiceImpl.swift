final class ProductServiceImpl {
    private var productRequest: VKRequest?
    
}

// MARK: - ProductService

extension ProductServiceImpl: ProductService {
    func cancelAllOperations() {
        productRequest?.cancel()
    }
    
    func getProducts(
        ownerId: Int,
        offset: Int,
        count: Int,
        completion: @escaping (Result<(products: [Product], count: Int), ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "owner_id": -ownerId,
            "offset": offset,
            "count": count,
        ]
        
        guard let request = VKApi.request(
            withMethod: "market.get",
            andParameters: parameters
        ) else {
            completion(.failure(.failInitRequest))
            return
        }

        productRequest = request
        request.execute(resultBlock: { object in
            let decoder = JSONDecoder()
            guard let responseString = object?.responseString else {
                completion(.failure(.failParse))
                return
            }
            
            let data = Data(responseString.utf8)
            do {
                let response = try decoder.decode(Response<ProductArray>.self, from: data)
                completion(.success((products: response.response.items, count: response.response.count)))
            } catch {
                completion(.failure(.failParse))
            }
        }) { error in
            completion(.failure(.fail))
        }
    }
    
    func addToFavorite(
        ownerId: Int,
        productId: Int,
        completion: @escaping (Result<Void, ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "owner_id": ownerId,
            "id": productId
        ]
        
        guard let request = VKApi.request(
            withMethod: "fave.addProduct",
            andParameters: parameters
        ) else {
            completion(.failure(.failInitRequest))
            return
        }
        
        request.execute(resultBlock: { object in
            completion(.success(()))
        }) { error in
            completion(.failure(.fail))
        }
    }
    
    func removeFromFavorite(
        ownerId: Int,
        productId: Int,
        completion: @escaping (Result<Void, ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "owner_id": ownerId,
            "id": productId,
        ]
        
        guard let request = VKApi.request(
            withMethod: "fave.removeProduct",
            andParameters: parameters
        ) else {
            completion(.failure(.failInitRequest))
            return
        }

        request.execute(resultBlock: { object in
            completion(.success(()))
        }) { error in
            completion(.failure(.fail))
        }
    }
}
