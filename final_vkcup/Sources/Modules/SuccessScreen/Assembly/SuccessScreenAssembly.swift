import UIKit

enum SuccessScreenAssembly {
    static func makeModule(
        inputData: SuccessScreenModuleInput
    ) -> UIViewController {
        let view = SuccessScreenViewController()

        let presenter = SuccessScreenPresenter(
            gift: inputData.gift
        )

        let interactor = SuccessScreenInteractor()

        let router = SuccessScreenRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
