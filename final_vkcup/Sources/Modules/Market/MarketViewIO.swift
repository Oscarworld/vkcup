enum ProductsPlaceholderState {
    case emptyList
    case failFetchProducts
}

/// Market view input
protocol MarketViewInput: class {
    func setupTitle(
        groupTitle: String
    )
    
    func reloadData()
    func appendViewModels(
        _ indexPaths: [IndexPath]
    )
    
    func endRefreshing()
    func showPlaceholder(_ state: ProductsPlaceholderState)
    func hidePlaceholder()
    func showActivity()
    func hideActivity()
    func showActivityOverCurrentContext()
    func hideActivityOverCurrentContext()
}

/// Market view output
protocol MarketViewOutput: class { 
	func setupView()
    
    func didPressBackButton()
    
    func numberOfItems() -> Int
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefProductViewModel?
    func getViewModels(
        in line: Int,
        numberRowInLine: Int
    ) -> [BriefProductViewModel]
    
    func didSelectItem(
        at indexPath: IndexPath
    )
    
    func didPressReload()
    
    func refreshDidPull()
    func didScrollToBottom()
}
