/// AddQuestStep view input
protocol AddQuestStepViewInput: class {
    func setupQuestType(item: SelectViewModel)
    
    func setupImage(_ image: UIImage)
    
    func setupLocation(address: String)
}

/// AddQuestStep view output
protocol AddQuestStepViewOutput: class { 
	func setupView()
    
    func didHandleType()
    
    func didHandleLocation()
    
    func didHandleAddImage()
    
    func didHandleCreateStep(
        image: UIImage?,
        title: String?,
        description: String?
    )
}
