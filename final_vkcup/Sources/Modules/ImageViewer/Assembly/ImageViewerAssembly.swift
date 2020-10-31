import UIKit

enum ImageViewerAssembly {
    static func makeModule(url: URL) -> UIViewController {
        let view = ImageViewerViewController()
        let presenter = ImageViewerPresenter(url: url)

        view.output = presenter
        presenter.view = view

        return view
    }
}
