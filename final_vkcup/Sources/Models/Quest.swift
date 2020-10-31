enum SponsorQuestAccess {
    case `public`
    case onlyForMembers
}

enum QuestType {
    case sponsor(SponsorQuestAccess)
    case personal
    case quest
    
}

struct Quest {
    var id: String
    var type: QuestType
    var owner: String
    var title: String
    var description: String
    var gifts: [QuestGift]
    var steps: [QuestStep]
    var accessIds: [String]
}
