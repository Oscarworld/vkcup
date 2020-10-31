/// AddMoney view input
protocol AddMoneyViewInput: class {
    func reloadData()
}

/// AddMoney view output
protocol AddMoneyViewOutput: class { 
	func setupView()
    
    func didHandleAddMoney(
        value: String
    )
    
    func numberOfItems() -> Int
    func getViewModel(
        in indexPath: IndexPath
    ) -> SelectViewModel?
    func getSelectedViewModel() -> SelectViewModel?
    func didSelectCell(
        at indexPath: IndexPath
    )
}
