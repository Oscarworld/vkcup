import UIKit.UIViewController

protocol QuestDetailsTransitionHandler: UIViewController { }

final class QuestDetailsRouter {
	weak var transitionHandler: QuestDetailsTransitionHandler?
}

// MARK: - QuestDetailsRouterInput

extension QuestDetailsRouter: QuestDetailsRouterInput {
    func close() {
        transitionHandler?.dismiss(
            animated: true,
            completion: nil
        )
    }
}
