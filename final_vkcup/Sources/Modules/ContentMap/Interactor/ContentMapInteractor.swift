final class ContentMapInteractor {

    // MARK: - VIPER

    weak var output: ContentMapInteractorOutput?

    // MARK: - Data
    
    private let questService: QuestService

    // MARK: - Init

	init(
        questService: QuestService
    ) {
        self.questService = questService
    }
}

// MARK: - ContentMapInteractorInput

extension ContentMapInteractor: ContentMapInteractorInput {
    func cancelAllOperations() {
        questService.cancelAllOperations()
    }
    
    func getQuests(
        requestType: QuestRequestType,
        lat: Double,
        lon: Double
    ) {
        questService.getQuests(
            requestType: requestType,
            lat: lat,
            lon: lon
        ) { [weak self] result in
            guard let output = self?.output else { return }
            
            switch result {
            case .success(let photos):
                output.didFetchQuests(photos)
            case .failure(let error):
                output.didFailFetchQuests(error)
            }
        }
    }
}
