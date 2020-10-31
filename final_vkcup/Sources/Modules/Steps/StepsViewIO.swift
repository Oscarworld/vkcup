/// Steps view input
protocol StepsViewInput: class {
    func reloadData()
    
    func showActivity()
    
    func hideActivity()
}

/// Steps view output
protocol StepsViewOutput: class { 
	func setupView()
    
    func numberOfSections() -> Int
    
    func numberOfItems(
        at section: Int
    ) -> Int
    
    func getSectionViewModel(
        at section: Int
    ) -> SectionViewModel?
    
    func getItemViewModel(
        at indexPath: IndexPath
    ) -> ItemViewModel?
    
    func didHandleStepButton(
        at idnexPath: IndexPath
    )
}

struct SectionViewModel {
    let title: String
    let image: UIImage?
}

struct ItemViewModel {
    let photoUrl: String
    let title: String
    let description: String
    let location: String
    let buttonTitle: String
}
