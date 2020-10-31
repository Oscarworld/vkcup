final class QRScanPresenter {

    // MARK: - VIPER

    var interactor: QRScanInteractorInput!
    var router: QRScanRouterInput!

	weak var view: QRScanViewInput?

    // MARK: - Init data

    init() { }
}

// MARK: - QRScanViewOutput

extension QRScanPresenter: QRScanViewOutput {
	func setupView() { }
}

// MARK: - QRScanInteractorOutput

extension QRScanPresenter: QRScanInteractorOutput { }

// MARK: - Localized

private extension QRScanPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension QRScanPresenter {
    enum Constants { }
}