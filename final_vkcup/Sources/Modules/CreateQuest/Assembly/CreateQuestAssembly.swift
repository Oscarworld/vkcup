import UIKit

enum CreateQuestAssembly {
    static func makeModule() -> UIViewController {
        let view = CreateQuestViewController()

        let presenter = CreateQuestPresenter()

        let interactor = CreateQuestInteractor()

        let router = CreateQuestRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}