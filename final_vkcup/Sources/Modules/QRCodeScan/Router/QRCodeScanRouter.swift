import UIKit.UIViewController

protocol QRCodeScanTransitionHandler: UIViewController { }

final class QRCodeScanRouter {
	weak var transitionHandler: QRCodeScanTransitionHandler?
}

// MARK: - QRCodeScanRouterInput

extension QRCodeScanRouter: QRCodeScanRouterInput { }
