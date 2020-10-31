import UIKit

/// Authorize view input
protocol AuthorizeViewInput: class {
    func showActivity()
    
    func hideActivity()
}

/// Authorize view output
protocol AuthorizeViewOutput: class {
    func setupView()
    
    func viewDidAppear()
    
    func didPressAuthorize()
    
    func showCaptchaEnter(
        _ captchaError: VKError!,
        in viewController: UIViewController
    )
}
