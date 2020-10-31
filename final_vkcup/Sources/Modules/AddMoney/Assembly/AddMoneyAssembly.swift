import UIKit

enum AddMoneyAssembly {
    static func makeModule(
        moduleOutput: AddMoneyModuleOutput?
    ) -> UIViewController {
        let view = AddMoneyViewController()

        let presenter = AddMoneyPresenter()

        let interactor = AddMoneyInteractor()

        let router = AddMoneyRouter()

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
