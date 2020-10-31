/// AddQuestStep router input
protocol AddQuestStepRouterInput: class {
    func openImagePicker(delegate: ImagePickerDelegate)
    
    func openSelectType(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    ) -> SelectActionSheetInput
    
    func openSelectLocation(
        moduleOutput: AddQuestStepLocationModuleOutput?
    )
    
    func closeSelectLocation()
}
