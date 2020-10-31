/// Steps router input
protocol StepsRouterInput: class {
    func showActionSheetView(
        title: String?,
        message: String?,
        actions: [UIAlertAction]
    )
    
    func showAlertWithTextField(
        alertController: UIAlertController
    )
    
    func openSuccessScreen(inputData: SuccessScreenModuleInput)
    
    func openSelectLocation(
        moduleOutput: AddQuestStepLocationModuleOutput?
    )
    
    func closeOpenSelectLocation(
        completion: (() -> Void)?
    )
    
    func openQRCodeScan(
        moduleOutput: QRCodeScanModuleOutput
    )
}
