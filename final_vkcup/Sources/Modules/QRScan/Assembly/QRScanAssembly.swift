import UIKit

enum QRScanAssembly {
    static func makeModule() -> UIViewController {
        let view = QRScanViewController()

        let presenter = QRScanPresenter()

        let interactor = QRScanInteractor()

        let router = QRScanRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}