/// AddQuestStepLocation view input
protocol AddQuestStepLocationViewInput: class {
    func setupAddress(
        _ address: String
    )
}

/// AddQuestStepLocation view output
protocol AddQuestStepLocationViewOutput: class { 
	func setupView()
    
    func moveCamera(
        lat: Double,
        lon: Double
    )
    
    func didHandleSelectLocation(
        address: String,
        lat: Double,
        lon: Double
    )
}
