import UIKit

protocol GroupsTransitionHandler: UIViewController { }

final class GroupsRouter: NSObject {
	weak var transitionHandler: GroupsTransitionHandler?
}

// MARK: - GroupsRouterInput

extension GroupsRouter: GroupsRouterInput {
    func showAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        preferredStyle: UIAlertController.Style
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        actions.forEach {
            alertController.addAction($0)
        }
        transitionHandler?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
        
    
    func openCitySelector(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    ) {
        let (view, _) = SelectActionSheetAssembly
            .makeModule(inputData: inputData, moduleOutput: moduleOutput)
        let viewController = ActionSheetTemplate(content: view)
        viewController.delegate = self
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func openGroup(
        inputData: MarketInputData,
        outputData: MarketModuleOutpudData
    ) {
        let viewController = MarketAssembly.makeModule(
            inputData: inputData,
            outputData: outputData
        )
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func closeGroup() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ActionSheetTemplateDelegate

extension GroupsRouter: ActionSheetTemplateDelegate {
    func actionSheetTemplateDidFinish(_ template: ActionSheetTemplate) {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension GroupsRouter: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return DimmingPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
