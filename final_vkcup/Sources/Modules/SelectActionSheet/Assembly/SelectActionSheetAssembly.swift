import UIKit

enum SelectActionSheetAssembly {
    static func makeModule(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    ) -> (view: UIViewController, moduleInput: SelectActionSheetInput) {
        let view = SelectActionSheetViewController()

        let presenter = SelectActionSheetPresenter(
            title: inputData.title,
            viewModels: inputData.viewModels,
            selected: inputData.selected
        )
        let router = SelectActionSheetRouter()

        view.output = presenter

        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput

        router.transitionHandler = view

        return (view: view, moduleInput: presenter)
    }
}
