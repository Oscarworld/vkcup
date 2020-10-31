enum QuestsServiceAssembly {
    static func makeQuestsService() -> QuestService {
        return QuestServiceMock()
    }
}
