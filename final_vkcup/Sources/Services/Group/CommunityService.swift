protocol GroupService {
    func cancelAllOperations()

    func getCities(
        completion: @escaping (Result<[City], ServiceError>) -> Void
    )
    
    func searchGroup(
        cityId: Int,
        offset: Int,
        count: Int,
        completion: @escaping (Result<(groups: [VKGroup], count: Int), ServiceError>) -> Void
    )
}
