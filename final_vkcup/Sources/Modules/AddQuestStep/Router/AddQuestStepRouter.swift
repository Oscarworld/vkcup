import UIKit.UIViewController

protocol AddQuestStepTransitionHandler: UIViewController { }

final class AddQuestStepRouter: NSObject {
	weak var transitionHandler: AddQuestStepTransitionHandler?
    private var imagePicker: ImagePicker?
}

// MARK: - AddQuestStepRouterInput

extension AddQuestStepRouter: AddQuestStepRouterInput {
    func openImagePicker(delegate: ImagePickerDelegate) {
        guard let presentationController = transitionHandler else { return }
        
        imagePicker = ImagePicker(
            presentationController: presentationController,
            delegate: delegate
        )
        imagePicker?.present()
    }
    
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
    
    func closeSelectLocation() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ActionSheetTemplateDelegate

extension AddQuestStepRouter: ActionSheetTemplateDelegate {
    func actionSheetTemplateDidFinish(_ template: ActionSheetTemplate) {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AddQuestStepRouter: UIViewControllerTransitioningDelegate {
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
