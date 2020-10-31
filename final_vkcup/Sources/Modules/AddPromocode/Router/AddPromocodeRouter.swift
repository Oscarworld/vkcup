import UIKit.UIViewController

protocol AddPromocodeTransitionHandler: UIViewController { }

final class AddPromocodeRouter {
	weak var transitionHandler: AddPromocodeTransitionHandler?
}

// MARK: - AddPromocodeRouterInput

extension AddPromocodeRouter: AddPromocodeRouterInput { }
