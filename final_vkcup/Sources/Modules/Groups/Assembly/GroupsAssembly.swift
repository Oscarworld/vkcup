import UIKit

enum GroupsAssembly {
    static func makeModule(
        outputData: GroupsModuleOutputData?
    ) -> UIViewController {
        let view = GroupsViewController()

        let groupViewModelFactory = GroupViewModelFactoryImpl()
        let cityViewModelFactory = CityViewModelFactoryImpl()
        let presenter = GroupsPresenter(
            groupViewModelFactory: groupViewModelFactory,
            cityViewModelFactory: cityViewModelFactory
        )

        let groupsService = GroupServiceAssembly.makeGroupService()
        let interactor = GroupsInteractor(
            goupsService: groupsService
        )

        let router = GroupsRouter()

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
