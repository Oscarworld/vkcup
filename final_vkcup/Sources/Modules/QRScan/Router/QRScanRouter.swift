import UIKit.UIViewController

protocol QRScanTransitionHandler: UIViewController { }

final class QRScanRouter {
	weak var transitionHandler: QRScanTransitionHandler?
}

// MARK: - QRScanRouterInput

extension QRScanRouter: QRScanRouterInput { }
