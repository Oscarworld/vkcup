import UIKit

enum GroupsPlaceholderState {
    case emptyList
    case failFetchGroups
    case failFetchCities
}

/// Groups view input
protocol GroupsViewInput: class {
    func setupCityTitle(
        _ title: String
    )
    func reloadData()
    func insertItems(
        _ indexPaths: [IndexPath]
    )
    
    func endRefreshing()
    func showPlaceholder(_ state: GroupsPlaceholderState)
    func hidePlaceholder()
    func showPaginationActivity()
    func showPaginationError()
    func hidePagination(forced: Bool)
    func showActivity()
    func hideActivity()
    func showActivityOverCurrentContext()
    func hideActivityOverCurrentContext()
}

/// Groups view output
protocol GroupsViewOutput: class { 
	func setupView()
    
    func numberOfItems() -> Int
    func getViewModel(
        in indexPath: IndexPath
    ) -> BriefGroupViewModel?
    func didSelectCell(
        at indexPath: IndexPath
    )
    
    func didPressCities()
    
    func didPressReload()
    func didPressReloadCities()
    
    func refreshDidPull()
    func didScrollToBottom()
}
