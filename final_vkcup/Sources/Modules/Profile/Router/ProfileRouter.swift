import UIKit.UIViewController

protocol ProfileTransitionHandler: UIViewController { }

final class ProfileRouter {
	weak var transitionHandler: ProfileTransitionHandler?
}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput { }
