import UIKit

enum ProductAssembly {
    static func makeModule(
        inputData: ProductInputData,
        outputData: ProductOutputData
    ) -> UIViewController {
        let view = ProductViewController()

        let presenter = ProductPresenter(
            productViewModel: inputData.viewModel,
            ownerId: inputData.ownerId,
            indexPath: inputData.indexPath
        )

        let interactor = ProductInteractor()

        let router = ProductRouter()

        view.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.outputData = outputData

        interactor.output = presenter

        router.transitionHandler = view

        return view
    }
}
