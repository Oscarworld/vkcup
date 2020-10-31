import UIKit.UIViewController

protocol SelectActionSheetTransitionHandler: UIViewController { }

final class SelectActionSheetRouter {
	weak var transitionHandler: SelectActionSheetTransitionHandler?
}

// MARK: - SelectActionSheetRouterInput

extension SelectActionSheetRouter: SelectActionSheetRouterInput {
    func close() {
        transitionHandler?.dismiss(
            animated: true,
            completion: nil
        )
    }
}
