import UIKit

enum ContentMapAssembly {
    static func makeModule() -> UIViewController {
        let view = ContentMapViewController()

        let presenter = ContentMapPresenter()

        let questService = QuestsServiceAssembly.makeQuestsService()
        let interactor = ContentMapInteractor(
            questService: questService
        )

        let router = ContentMapRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
