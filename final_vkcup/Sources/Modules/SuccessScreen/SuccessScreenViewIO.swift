/// SuccessScreen view input
protocol SuccessScreenViewInput: class {
    func setupGift(_ gift: QuestGift)
    
    func runConfetti()
}

/// SuccessScreen view output
protocol SuccessScreenViewOutput: class { 
	func setupView()
    
    func viewDidAppear()
}
