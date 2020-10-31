/// QuestDetails view input
protocol QuestDetailsViewInput: class {
    func setViewModel(
        title: String,
        description: String,
        location: String,
        owner: String,
        gifts: String
    )
    
    func showActivity()
    
    func hideActivity()
    
    func setupButtonTitle(
        _ title: String
    )
}

/// QuestDetails view output
protocol QuestDetailsViewOutput: class { 
	func setupView()
    
    func didPressOpenButton()
    
    func didPressCloseButton()
}
