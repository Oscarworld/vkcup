import UIKit

enum AddFriendAssembly {
    static func makeModule(
        moduleOutput: AddFriendModuleOutput?
    ) -> UIViewController {
        let view = AddFriendViewController()

        let friendsViewModelFactory = FriendsViewModelFactoryImpl()
        let presenter = AddFriendPresenter(
            friendsViewModelFactory: friendsViewModelFactory
        )

        let friendsService = FriendsServiceAssembly.makeFriendsService()
        let interactor = AddFriendInteractor(
            friendsService: friendsService
        )

        let router = AddFriendRouter()

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
