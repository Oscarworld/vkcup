import UIKit.UIViewController

protocol ContentMapTransitionHandler: UIViewController { }

final class ContentMapRouter: NSObject {
	weak var transitionHandler: ContentMapTransitionHandler?
}

// MARK: - ContentMapRouterInput

extension ContentMapRouter: ContentMapRouterInput {
    func openQuestDetails(
        inputData: QuestDetailsModuleInput,
        outputData: QuestDetailsModuleOutput
    ) {
        let content = QuestDetailsAssembly.makeModule(
            inputData: inputData,
            outputData: outputData
        )
        let viewController = ActionSheetTemplate(content: content)
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
    
    func openSponsorQuestDetails(
        _ quest: Quest,
        location: String
    ) {
        let inputData = SponsorQuestDetailsModuleInput(
            quest: quest,
            location: location
        )
        let viewController = SponsorQuestDetailsAssembly.makeModule(
            inputData: inputData
        )
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
    
    func openImageDocs(
        with url: URL
    ) {
        let viewController = ImageViewerAssembly.makeModule(url: url)
        viewController.modalPresentationStyle = .fullScreen
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
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
}

// MARK: - ActionSheetTemplateDelegate

extension ContentMapRouter: ActionSheetTemplateDelegate {
    func actionSheetTemplateDidFinish(_ template: ActionSheetTemplate) {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ContentMapRouter: UIViewControllerTransitioningDelegate {
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
