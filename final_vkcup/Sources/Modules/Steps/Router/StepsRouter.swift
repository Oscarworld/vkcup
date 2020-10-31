import UIKit.UIViewController

protocol StepsTransitionHandler: UIViewController { }

final class StepsRouter {
	weak var transitionHandler: StepsTransitionHandler?
}

// MARK: - StepsRouterInput

extension StepsRouter: StepsRouterInput {
    func showActionSheetView(
        title: String?,
        message: String?,
        actions: [UIAlertAction]
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        actions.forEach { alertController.addAction($0) }
        transitionHandler?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    func showAlertWithTextField(
        alertController: UIAlertController
    ) {
        transitionHandler?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    func openSuccessScreen(inputData: SuccessScreenModuleInput) {
        let viewController = SuccessScreenAssembly.makeModule(inputData: inputData)
        viewController.modalPresentationStyle = .formSheet
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func openSelectLocation(
        moduleOutput: AddQuestStepLocationModuleOutput?
    ) {
        let viewController = AddQuestStepLocationAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func closeOpenSelectLocation(
        completion: (() -> Void)?
    ) {
        transitionHandler?.dismiss(animated: true, completion: completion)
    }
    
    func openQRCodeScan(
        moduleOutput: QRCodeScanModuleOutput
    ) {
        let viewController = QRCodeScanAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
}
