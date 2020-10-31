// MARK: - QuestDetails module input

struct QuestDetailsModuleInput {
    let quest: Quest
}

// MARK: - QuestDetails module output

protocol QuestDetailsModuleOutput: class {
    func didHandleOpenQuest(
        _ quest: Quest,
        location: String
    )
}
