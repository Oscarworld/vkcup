/// Product view input
protocol ProductViewInput: class {
    func setupViewModel(
        _ viewModel: BriefProductViewModel
    )
    
    func setupIsFavorite(
        _ isFavorite: Bool
    )
    
    func showActivityOverCurrentContext()
    func hideActivityOverCurrentContext()
}

/// Product view output
protocol ProductViewOutput: class { 
	func setupView()
    
    func didPressBackButton()
    
    func didPressFavoriteButton()
}
