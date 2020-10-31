import UIKit

/// Authorize router input
protocol AuthorizeRouterInput: class {
    func showAlert(
        title: String?,
        message: String?
    )
    
    func openMainPage()
    
    func popToRootViewController()
    
    func openVKSDK(viewController: UIViewController)
    
    func operCaptchaEnter(_ captchaError: VKError!)
}
