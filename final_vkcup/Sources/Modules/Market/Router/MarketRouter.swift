import UIKit.UIViewController

protocol MarketTransitionHandler: UIViewController { }

final class MarketRouter {
	weak var transitionHandler: MarketTransitionHandler?
}

// MARK: - MarketRouterInput

extension MarketRouter: MarketRouterInput {
    func showAlert(
        title: String?,
        message: String?
    ) {
        let okAction = UIAlertAction.okAction
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(okAction)
        transitionHandler?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    func openProduct(
        inputData: ProductInputData,
        outputData: ProductOutputData
    ) {
        let viewController = ProductAssembly.makeModule(
            inputData: inputData,
            outputData: outputData
        )
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func close() {
        transitionHandler?.dismiss(
            animated: true,
            completion: nil
        )
    }
}
