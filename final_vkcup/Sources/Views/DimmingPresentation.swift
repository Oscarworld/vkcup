import UIKit.UIColor
import UIKit.UIPresentationController
import UIKit.UIView

/// Presentation controller with add dimming view
open class DimmingPresentationController: UIPresentationController {

    public var preferredBackgroundColor = UIColor(white: 0, alpha: 0.4)

    open override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        setupDimmingView()

        guard let dimmingView = dimmingView else { return }

        containerView.addSubview(dimmingView)
        dimmingView.backgroundColor = preferredBackgroundColor

        let constraints = [
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)

        presentedView?.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleWidth,
            .flexibleHeight,
        ]

        dimmingView.alpha = 0
        let alpha: CGFloat = 1
        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView.alpha = alpha
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = alpha
        })
    }

    open override func dismissalTransitionWillBegin() {
        let alpha: CGFloat = 0
        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView?.alpha = alpha
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = alpha
        })
    }

    open override func presentationTransitionDidEnd(_ completed: Bool) {
        guard completed == false else { return }
        dimmingView?.removeFromSuperview()
        dimmingView = nil
    }

    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else { return }
        dimmingView?.removeFromSuperview()
        dimmingView = nil
    }

    private var dimmingView: UIView?

    private func setupDimmingView() {
        dimmingView?.removeFromSuperview()
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        dimmingView = view
    }
}
