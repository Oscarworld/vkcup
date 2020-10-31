import UIKit

enum ProfileAssembly {
    static func makeModule() -> UIViewController {
        let view = ProfileViewController()

        let presenter = ProfilePresenter()

        let interactor = ProfileInteractor()

        let router = ProfileRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}