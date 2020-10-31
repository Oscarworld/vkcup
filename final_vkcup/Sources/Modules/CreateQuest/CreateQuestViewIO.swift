/// CreateQuest view input
protocol CreateQuestViewInput: class {
    func setupQuestType(item: SelectViewModel)
    
    func addMoney(
        _ money: SelectViewModel,
        value: String
    )
    
    func addProduct(
        _ product: BriefProductViewModel
    )
    
    func addPromocode(
        _ promocode: PromocodeViewModel
    )
    
    func addFriend(
        _ friend: BriefGroupViewModel
    )
    
    func addStep(
        image: UIImage?,
        typeImage: UIImage?,
        title: String?,
        description: String?
    )
}

/// CreateQuest view output
protocol CreateQuestViewOutput: class { 
	func setupView()
    
    func didHandleType()
    
    func didHandleAddGift()
    
    func didHandleCreateButton()
    
    func didHandleAddFriend()
    
    func didHandleAddStep()
}
