import UIKit.UIViewController

protocol SuccessCreateQuestTransitionHandler: UIViewController { }

final class SuccessCreateQuestRouter {
	weak var transitionHandler: SuccessCreateQuestTransitionHandler?
}

// MARK: - SuccessCreateQuestRouterInput

extension SuccessCreateQuestRouter: SuccessCreateQuestRouterInput { }
