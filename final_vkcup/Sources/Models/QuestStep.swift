enum QuestStepType {
    case qr
    case location
    case question((question: String, answer: String))
}

enum QuestStepAvailableType {
    case available
    case locked
    case completed
}

struct QuestStep {
    var id: String
    var type: QuestStepType
    var title: String
    var description: String
    var photo: String
    var lat: Double
    var lon: Double
    var availableType: QuestStepAvailableType
}
