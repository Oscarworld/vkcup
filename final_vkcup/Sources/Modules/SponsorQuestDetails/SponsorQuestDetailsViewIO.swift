/// SponsorQuestDetails view input
protocol SponsorQuestDetailsViewInput: class {
    func setupQuest(
        _ quest: Quest,
        location: String
    )
}

/// SponsorQuestDetails view output
protocol SponsorQuestDetailsViewOutput: class { 
	func setupView()
    
    func didHandleSubmitButton()
}
