import UIKit

enum QuestDetailsAssembly {
    static func makeModule(
        inputData: QuestDetailsModuleInput,
        outputData: QuestDetailsModuleOutput
    ) -> UIViewController {
        let view = QuestDetailsViewController()

        let presenter = QuestDetailsPresenter(
            quest: inputData.quest
        )

        let interactor = QuestDetailsInteractor()

        let router = QuestDetailsRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.output = outputData

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
