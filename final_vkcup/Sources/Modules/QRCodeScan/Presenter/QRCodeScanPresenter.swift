final class QRCodeScanPresenter {

    // MARK: - VIPER

    var interactor: QRCodeScanInteractorInput!
    var router: QRCodeScanRouterInput!

	weak var view: QRCodeScanViewInput?
    weak var moduleOutput: QRCodeScanModuleOutput?

    // MARK: - Init data

    init() { }
}

// MARK: - QRCodeScanViewOutput

extension QRCodeScanPresenter: QRCodeScanViewOutput {
	func setupView() { }
    
    func didScanQRCode(url: String?) {
        moduleOutput?.didScanQRCode(url: url)
    }
}

// MARK: - QRCodeScanInteractorOutput

extension QRCodeScanPresenter: QRCodeScanInteractorOutput { }

// MARK: - Localized

private extension QRCodeScanPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QRCodeScanPresenter {
    enum Constants { }
}
