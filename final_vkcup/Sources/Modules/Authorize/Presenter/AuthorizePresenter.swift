final class AuthorizePresenter: NSObject {

    // MARK: - VIPER

    var router: AuthorizeRouterInput!

	weak var view: AuthorizeViewInput?
    
    // MARK: - Data
    
    private let vkAppId: String
    private let scope: [String]
    
    // MARK: - Init

    init(
        vkAppId: String,
        scope: [String]
    ) {
        self.vkAppId = vkAppId
        self.scope = scope
    }
}

// MARK: - AuthorizeViewOutput

extension AuthorizePresenter: AuthorizeViewOutput {
    func setupView() {
        view?.showActivity()
        VKSdk.initialize(withAppId: vkAppId)
        VKSdk.instance()?.register(self)
        VKSdk.instance()?.uiDelegate = self
    }
    
    func viewDidAppear() {
        VKSdk.wakeUpSession(scope) { [weak self] state, error in
            guard let self = self else { return }
            
            if state == .authorized {
                self.successAuthorized()
            } else if let error = error {
                self.view?.hideActivity()
                self.router.showAlert(
                    title: Localized.AuthorizationFailed.title,
                    message: error.localizedDescription
                )
            } else {
                self.authorize()
            }
        }
    }
    
    func didPressAuthorize() {
        authorize()
    }
    
    func showCaptchaEnter(
        _ captchaError: VKError!,
        in viewController: UIViewController
    ) {
        guard let captchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError) else {
            return
        }
        view?.hideActivity()
        captchaViewController.present(in: viewController)
    }
    
    private func authorize() {
        view?.showActivity()
        VKSdk.authorize(scope)
    }
    
    private func successAuthorized() {
        router.openMainPage()
    }
}

// MARK: - VKSdkDelegate

extension AuthorizePresenter: VKSdkDelegate {
    func vkSdkTokenHasExpired(
        _ expiredToken: VKAccessToken!
    ) {
        authorize()
    }
    
    func vkSdkAccessAuthorizationFinished(
        with result: VKAuthorizationResult!
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if result.token != nil {
                self.successAuthorized()
            } else if let error = result.error {
                self.view?.hideActivity()
                self.router.showAlert(
                    title: Localized.AuthorizationFailed.title,
                    message: error.localizedDescription
                )
            }
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        view?.hideActivity()
        router.showAlert(
            title: Localized.AuthorizationFailed.title,
            message: Localized.AuthorizationFailed.message
        )
    }
}

// MARK: - VKSdkUIDelegate

extension AuthorizePresenter: VKSdkUIDelegate {
    func vkSdkShouldPresent(
        _ controller: UIViewController!
    ) {
        guard let viewController = controller else { return }
        router.openVKSDK(viewController: viewController)
    }
    
    func vkSdkNeedCaptchaEnter(
        _ captchaError: VKError!
    ) {
        router.operCaptchaEnter(captchaError)
    }
}

// MARK: - Localized

private extension AuthorizePresenter {
    enum Localized {
        // swiftlint:disable line_length
        enum AuthorizationFailed {
            static let title = NSLocalizedString(
                "AuthorizePresenter.AuthorizationFailed.Title",
                value: "Ошибка авторизации",
                comment: "Title ошибки авторизации на экране Авторизации"
            )
            static let message = NSLocalizedString(
                "AuthorizePresenter.AuthorizationFailed.Message",
                value: "Доступ запрещен",
                comment: "Message ошибки авторизации на экране Авторизации"
            )
        }
        // swiftlint:enable line_length
    }
}
