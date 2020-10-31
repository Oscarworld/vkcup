import UIKit.UIViewController

protocol AddMoneyTransitionHandler: UIViewController { }

final class AddMoneyRouter {
	weak var transitionHandler: AddMoneyTransitionHandler?
}

// MARK: - AddMoneyRouterInput

extension AddMoneyRouter: AddMoneyRouterInput { }
