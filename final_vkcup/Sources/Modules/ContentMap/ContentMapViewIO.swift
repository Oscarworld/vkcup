/// ContentMap view input
protocol ContentMapViewInput: class {
    func setupClusterManager()
    
    func setupQuests(
        _ quests: [Quest]
    )
}

/// ContentMap view output
protocol ContentMapViewOutput: class { 
	func setupView()
    
    func changeQuestRequestType(
        _ type: QuestRequestType,
        lat: Double,
        lon: Double
    )
    
    func moveCamera(
        lat: Double,
        lon: Double
    )

    func didHandleQuest(
        _ quest: Quest
    )
}
