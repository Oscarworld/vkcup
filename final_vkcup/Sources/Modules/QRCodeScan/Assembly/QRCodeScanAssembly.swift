import UIKit

enum QRCodeScanAssembly {
    static func makeModule(
        moduleOutput: QRCodeScanModuleOutput
    ) -> UIViewController {
        let view = QRCodeScanViewController()

        let presenter = QRCodeScanPresenter()

        let interactor = QRCodeScanInteractor()

        let router = QRCodeScanRouter()

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
