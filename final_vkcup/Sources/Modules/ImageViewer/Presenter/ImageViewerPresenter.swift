import UIKit

final class ImageViewerPresenter {

    // MARK: - VIPER

	weak var view: ImageViewerViewInput?

    // MARK: - Init data
    
    private let url: URL

    // MARK: - Init

    init(url: URL) {
        self.url = url
    }
}

// MARK: - ImageViewerViewOutput

extension ImageViewerPresenter: ImageViewerViewOutput {
	func setupView() {
        view?.loadImage(url)
    }
}
