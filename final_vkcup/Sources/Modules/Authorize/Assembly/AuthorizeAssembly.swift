import UIKit

enum AuthorizeAssembly {
    static func makeModule() -> UIViewController {
        let view = AuthorizeViewController()
        let scope = [
            "friends",
            "groups",
            "market",
            "photos",
        ]
        let presenter = AuthorizePresenter(
            vkAppId: "7321718",
            scope: scope
        )
        let router = AuthorizeRouter()

        view.output = presenter

        presenter.view = view
        presenter.router = router

        router.transitionHandler = view

        return view
    }
}
