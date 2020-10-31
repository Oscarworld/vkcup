import UIKit

enum AddPromocodeAssembly {
    static func makeModule(
        moduleOutput: AddPromocodeModuleOutput?
    ) -> UIViewController {
        let view = AddPromocodeViewController()

        let presenter = AddPromocodePresenter()

        let interactor = AddPromocodeInteractor()

        let router = AddPromocodeRouter()

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
