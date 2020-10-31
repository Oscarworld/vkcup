import UIKit.UIViewController

protocol ProductTransitionHandler: UIViewController { }

final class ProductRouter {
	weak var transitionHandler: ProductTransitionHandler?
}

// MARK: - ProductRouterInput

extension ProductRouter: ProductRouterInput {
    func close() {
        transitionHandler?.dismiss(
            animated: true,
            completion: nil
        )
    }
    
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
}
