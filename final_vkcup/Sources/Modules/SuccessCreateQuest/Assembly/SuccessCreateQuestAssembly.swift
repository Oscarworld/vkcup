import UIKit

enum SuccessCreateQuestAssembly {
    static func makeModule() -> UIViewController {
        let view = SuccessCreateQuestViewController()

        let presenter = SuccessCreateQuestPresenter()

        let interactor = SuccessCreateQuestInteractor()

        let router = SuccessCreateQuestRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}