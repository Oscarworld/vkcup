/// ContentMap interactor input
protocol ContentMapInteractorInput {
    func cancelAllOperations()
    
    func getQuests(
        requestType: QuestRequestType,
        lat: Double,
        lon: Double
    )
}

/// ContentMap interactor output
protocol ContentMapInteractorOutput: class {
    func didFetchQuests(
        _ quests: [Quest]
    )
    
    func didFailFetchQuests(
        _ error: ServiceError
    )
}
