import UIKit

protocol AuthorizeTransitionHandler: UIViewController {
    func needPresentCaptchaEnter(_ captchaError: VKError!)
}

final class AuthorizeRouter {
	weak var transitionHandler: AuthorizeTransitionHandler?
}

// MARK: - AuthorizeRouterInput

extension AuthorizeRouter: AuthorizeRouterInput {
    func showAlert(
        title: String?,
        message: String?
    ) {
        let okAction = UIAlertAction.okAction
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(okAction)
        transitionHandler?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    func openMainPage() {
        guard let currentWindow = UIApplication.shared.keyWindow,
              let snapshot = currentWindow.snapshotView(afterScreenUpdates: true) else { return }
        
        let tabBarController = makeTabBarController()
        tabBarController.view.addSubview(snapshot)
        currentWindow.rootViewController = tabBarController
        
        UIView.animate(withDuration: 0.5, animations: {
            snapshot.layer.opacity = 0
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        }) { _ in
            snapshot.removeFromSuperview()
        }
    }
    
    func popToRootViewController() {
//        transitionHandler?.popToRootViewController(animated: true)
    }
    
    func openVKSDK(viewController: UIViewController) {
        transitionHandler?.present(
            viewController,
            animated: true,
            completion: nil
        )
    }
    
    func operCaptchaEnter(_ captchaError: VKError!) {
        transitionHandler?.needPresentCaptchaEnter(captchaError)
    }
}

// MARK: - Create main page

private extension AuthorizeRouter {
    private func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            makeMapController(),
            makeCreateQuestController(),
            makeProfileController(),
        ]
        return tabBarController
    }
    
    private func makeMapController() -> UIViewController {
        let viewController = ContentMapAssembly.makeModule()
        return UINavigationController(
            rootViewController: viewController
        )
    }
    
    private func makeCreateQuestController() -> UIViewController {
        let viewController = CreateQuestAssembly.makeModule()
        return UINavigationController(
            rootViewController: viewController
        )
    }
    
    private func makeProfileController() -> UIViewController {
        let viewController = ProfileAssembly.makeModule()
        return UINavigationController(
            rootViewController: viewController
        )
    }
}
