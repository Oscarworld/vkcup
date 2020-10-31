/// CreateQuest router input
protocol CreateQuestRouterInput: class {
    func openSelectType(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    ) -> SelectActionSheetInput
    
    func showActionSheetView(
        title: String?,
        message: String?,
        actions: [UIAlertAction]
    )
    
    func openSelectProduct(
        outputData: GroupsModuleOutputData
    )
    
    func closeSelectProduct()
    
    func openAddPromocode(
        moduleOutput: AddPromocodeModuleOutput?
    )
    
    func closeAddPromocode()
    
    func openAddFriends(
        moduleOutput: AddFriendModuleOutput?
    )
    
    func openAddMoney(
        moduleOutput: AddMoneyModuleOutput?
    )
    
    func opemAddQuestStep(
        moduleOutput: AddQuestStepModuleOutput?
    )
    
    func showSuccessCreateQuest()
}
