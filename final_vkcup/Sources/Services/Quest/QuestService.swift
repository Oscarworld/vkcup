protocol QuestService {
    func cancelAllOperations()
    
    func getQuests(
        requestType: QuestRequestType,
        lat: Double,
        lon: Double,
        completion: @escaping (Result<[Quest], ServiceError>) -> Void
    )
}
