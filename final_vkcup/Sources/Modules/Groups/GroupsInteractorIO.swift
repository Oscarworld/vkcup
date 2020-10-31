enum GroupsInteractorUpdatingContext {
    case initial
    case pagination
    case reload
}

/// Groups interactor input
protocol GroupsInteractorInput {
    func cancelAllOperations()
    
    func getCities()
    
    func getGroups(
        cityId: Int,
        count: Int,
        offset: Int,
        context: GroupsInteractorUpdatingContext
    )
}

/// Groups interactor output
protocol GroupsInteractorOutput: class {
    func didFetchCities(
        _ cities: [City]
    )
    
    func didFailFetchCities(
        _ error: ServiceError
    )
    
    func didFetchGroups(
        count: Int,
        groups: [VKGroup],
        context: GroupsInteractorUpdatingContext
    )
    
    func didFailFetchGroups(
        _ error: ServiceError,
        context: GroupsInteractorUpdatingContext
    )
}
