import UIKit.UIViewController

protocol SuccessScreenTransitionHandler: UIViewController { }

final class SuccessScreenRouter {
	weak var transitionHandler: SuccessScreenTransitionHandler?
}

// MARK: - SuccessScreenRouterInput

extension SuccessScreenRouter: SuccessScreenRouterInput { }
