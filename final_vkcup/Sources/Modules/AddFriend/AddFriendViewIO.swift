enum AddFriendPlaceholderState {
    case emptyList
    case failFetchFriends
}

/// AddFriend view input
protocol AddFriendViewInput: class {
    func reloadData()
    func insertItems(
        _ indexPaths: [IndexPath]
    )
    
    func endRefreshing()
    func showPlaceholder(_ state: AddFriendPlaceholderState)
    func hidePlaceholder()
    func showPaginationActivity()
    func showPaginationError()
    func hidePagination(forced: Bool)
    func showActivity()
    func hideActivity()
    func showActivityOverCurrentContext()
    func hideActivityOverCurrentContext()
}

/// AddFriend view output
protocol AddFriendViewOutput: class { 
	func setupView()
    
    func numberOfItems() -> Int
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefGroupViewModel?
    func didSelectCell(
        at indexPath: IndexPath
    )
    
    func didPressReload()
    func refreshDidPull()
    func didScrollToBottom()
}
