import UIKit

enum MarketAssembly {
    static func makeModule(
        inputData: MarketInputData,
        outputData: MarketModuleOutpudData
    ) -> UIViewController {
        let view = MarketViewController()

        let productViewModelFactory = ProductViewModelFactoryImpl()
        let presenter = MarketPresenter(
            groupId: inputData.groupId,
            groupTitle: inputData.groupTitle,
            productViewModelFactory: productViewModelFactory
        )

        let productService = ProductServiceAssembly.makeProductService()
        let interactor = MarketInteractor(productService: productService)

        let router = MarketRouter()

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
