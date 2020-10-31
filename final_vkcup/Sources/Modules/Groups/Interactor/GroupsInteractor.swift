final class GroupsInteractor {

    // MARK: - VIPER

    weak var output: GroupsInteractorOutput?

    // MARK: - Data
    
    private let goupsService: GroupService

    // MARK: - Init

    init(goupsService: GroupService) {
        self.goupsService = goupsService
    }
}

// MARK: - GroupsInteractorInput

extension GroupsInteractor: GroupsInteractorInput {
    func cancelAllOperations() {
        goupsService.cancelAllOperations()
    }
    
    func getCities() {
        goupsService.getCities { [weak self] result in
            guard let output = self?.output else { return }
            
            switch result {
            case .success(let cities):
                output.didFetchCities(cities)
            case .failure(let error):
                output.didFailFetchCities(error)
            }
        }
    }
    
    func getGroups(
        cityId: Int,
        count: Int,
        offset: Int,
        context: GroupsInteractorUpdatingContext
    ) {
        goupsService.searchGroup(
            cityId: cityId,
            offset: offset,
            count: count
        ) { [weak self] result in
            guard let output = self?.output else { return }
            
            switch result {
            case .success(let result):
                output.didFetchGroups(
                    count: result.count,
                    groups: result.groups,
                    context: context
                )
            case .failure(let error):
                output.didFailFetchGroups(
                    error,
                    context: context
                )
            }
        }
    }
}
