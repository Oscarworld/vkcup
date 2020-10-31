import UIKit.UIViewController

protocol CreateQuestTransitionHandler: UIViewController { }

final class CreateQuestRouter: NSObject {
	weak var transitionHandler: CreateQuestTransitionHandler?
}

// MARK: - CreateQuestRouterInput

extension CreateQuestRouter: CreateQuestRouterInput {
    func openSelectType(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    ) -> SelectActionSheetInput {
        let (view, moduleInput) = SelectActionSheetAssembly
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
        return moduleInput
    }
    
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
    
    func openSelectProduct(
        outputData: GroupsModuleOutputData
    ) {
        let viewController = GroupsAssembly.makeModule(
            outputData: outputData
        )
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
    
    func closeSelectProduct() {
        transitionHandler?.navigationController?.popViewController(animated: false)
    }
    
    func openAddPromocode(
        moduleOutput: AddPromocodeModuleOutput?
    ) {
        let viewController = AddPromocodeAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func closeAddPromocode() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
    
    func openAddFriends(
        moduleOutput: AddFriendModuleOutput?
    ) {
        let viewController = AddFriendAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func openAddMoney(
        moduleOutput: AddMoneyModuleOutput?
    ) {
        let viewController = AddMoneyAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func opemAddQuestStep(
        moduleOutput: AddQuestStepModuleOutput?
    ) {
        let viewController = AddQuestStepAssembly.makeModule(moduleOutput: moduleOutput)
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func showSuccessCreateQuest() {
        let viewController = SuccessCreateQuestAssembly.makeModule()
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
}

// MARK: - ActionSheetTemplateDelegate

extension CreateQuestRouter: ActionSheetTemplateDelegate {
    func actionSheetTemplateDidFinish(_ template: ActionSheetTemplate) {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CreateQuestRouter: UIViewControllerTransitioningDelegate {
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
