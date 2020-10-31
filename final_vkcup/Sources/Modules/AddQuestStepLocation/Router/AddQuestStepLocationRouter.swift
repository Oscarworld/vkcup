import UIKit.UIViewController

protocol AddQuestStepLocationTransitionHandler: UIViewController { }

final class AddQuestStepLocationRouter {
	weak var transitionHandler: AddQuestStepLocationTransitionHandler?
}

// MARK: - AddQuestStepLocationRouterInput

extension AddQuestStepLocationRouter: AddQuestStepLocationRouterInput { }
