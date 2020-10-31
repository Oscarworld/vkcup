import UIKit

/// ImageViewer view input
protocol ImageViewerViewInput: class {
    func loadImage(
        _ url: URL
    )
}

/// ImageViewer view output
protocol ImageViewerViewOutput: class { 
	func setupView()
}
