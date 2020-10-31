import UIKit

enum SponsorQuestDetailsAssembly {
    static func makeModule(
        inputData: SponsorQuestDetailsModuleInput
    ) -> UIViewController {
        let view = SponsorQuestDetailsViewController()

        let presenter = SponsorQuestDetailsPresenter(
            quest: inputData.quest,
            location: inputData.location
        )

        let interactor = SponsorQuestDetailsInteractor()

        let router = SponsorQuestDetailsRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
