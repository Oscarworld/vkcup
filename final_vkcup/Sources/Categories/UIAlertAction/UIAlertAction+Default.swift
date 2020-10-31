import UIKit

extension UIAlertAction {
    static let okAction = UIAlertAction(
        title: Localized.okActionTitle,
        style: .default,
        handler: nil
    )
}

private extension UIAlertAction {
    enum Localized {
        // swiftlint:disable line_length
        static let okActionTitle = NSLocalizedString(
            "UIAlertAction.okActionTitle",
            value: "Ok",
            comment: "Title стандартного действия UIAlertAction авторизации"
        )
        // swiftlint:enable line_length
    }
}
