import UIKit.UIViewController

protocol AddFriendTransitionHandler: UIViewController { }

final class AddFriendRouter {
	weak var transitionHandler: AddFriendTransitionHandler?
}

// MARK: - AddFriendRouterInput

extension AddFriendRouter: AddFriendRouterInput {
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
