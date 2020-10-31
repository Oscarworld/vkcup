import UIKit

enum StepsAssembly {
    static func makeModule(
        inputData: StepsModuleInput
    ) -> UIViewController {
        let view = StepsViewController()

        let presenter = StepsPresenter(
            quest: inputData.quest
        )

        let interactor = StepsInteractor()

        let router = StepsRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
