import UIKit

enum AddQuestStepLocationAssembly {
    static func makeModule(
        moduleOutput: AddQuestStepLocationModuleOutput?
    ) -> UIViewController {
        let view = AddQuestStepLocationViewController()

        let presenter = AddQuestStepLocationPresenter()

        let interactor = AddQuestStepLocationInteractor()

        let router = AddQuestStepLocationRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.moduleOutput = moduleOutput

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
