import UIKit

enum AddQuestStepAssembly {
    static func makeModule(
        moduleOutput: AddQuestStepModuleOutput?
    ) -> UIViewController {
        let view = AddQuestStepViewController()

        let presenter = AddQuestStepPresenter()

        let interactor = AddQuestStepInteractor()

        let router = AddQuestStepRouter()

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
