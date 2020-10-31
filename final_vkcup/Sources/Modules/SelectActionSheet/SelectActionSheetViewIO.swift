/// SelectActionSheet view input
protocol SelectActionSheetViewInput: class {
    func setupTitle(
        _ title: String
    )
    
    func reloadData()
}

/// SelectActionSheet view output
protocol SelectActionSheetViewOutput: class { 
	func setupView()
    
    func numberOfItems() -> Int
    func getViewModel(
        in indexPath: IndexPath
    ) -> SelectViewModel?
    func getSelectedViewModel() -> SelectViewModel?
    func didSelectCell(
        at indexPath: IndexPath
    )
    
    func didPressCloseButton()
}
