import UIKit.UIViewController

protocol SponsorQuestDetailsTransitionHandler: UIViewController { }

final class SponsorQuestDetailsRouter {
	weak var transitionHandler: SponsorQuestDetailsTransitionHandler?
}

// MARK: - SponsorQuestDetailsRouterInput

extension SponsorQuestDetailsRouter: SponsorQuestDetailsRouterInput {
    func openSteps(
        inputData: StepsModuleInput
    ) {
        let viewController = StepsAssembly.makeModule(inputData: inputData)
        transitionHandler?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
