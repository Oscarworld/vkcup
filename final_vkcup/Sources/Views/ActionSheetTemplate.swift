import UIKit

public protocol ActionSheetTemplateDelegate: class {
    func actionSheetTemplateDidFinish(_ template: ActionSheetTemplate)
}

public class ActionSheetTemplate: UIViewController {

    public init(content: UIViewController) {
        self.contentViewController = content
        super.init(nibName: nil, bundle: nil)
        addChild(contentViewController)
    }

    @available(*, unavailable, message: "Use init(content:) instead")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(content:) instead")
    }

    private let contentViewController: UIViewController

    public weak var delegate: ActionSheetTemplateDelegate?

    // MARK: - UI properties

    fileprivate var contentView: UIView! {
        return contentViewController.view
    }

    private lazy var dummyView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.Styles.white
        $0.layer.mask = maskLayer
        $0.layer.masksToBounds = true
        $0.layoutMargins = .zero
        $0.addGestureRecognizer(panGesture)
        return $0
    }(UIView())

    // MARK: - Configuring the View Rotation Settings

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask
        switch (traitCollection.userInterfaceIdiom, traitCollection.horizontalSizeClass) {
        case (.phone, .compact):
            orientation = .portrait
        default:
            orientation = .all
        }
        return orientation
    }

    // MARK: - Layer properties

    private let maskLayer = CAShapeLayer()

    // MARK: - Constraints properties

    fileprivate lazy var dummyViewHeightConstraint: NSLayoutConstraint = {
        $0.priority = .defaultHigh
        return $0
    }(self.dummyView.heightAnchor.constraint(equalToConstant: 0))

    fileprivate lazy var dummyViewLeadingConstraint: NSLayoutConstraint = {
        $0.priority = .defaultHigh
        return $0
    }(self.dummyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))

    fileprivate lazy var dummyViewCompactHeightConstraint: NSLayoutConstraint =
        self.dummyView.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor,
                                               multiplier: Constants.compactHeightMultiplier)

    fileprivate lazy var dummyViewRegularHeightConstraint: NSLayoutConstraint =
        self.dummyView.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor,
                                               multiplier: Constants.regularHeightMultiplier)

    fileprivate lazy var dummyViewBottomConstraint: NSLayoutConstraint =
        self.dummyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

    // MARK: - Gesture recognizers

    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognizerHandle))

    fileprivate lazy var viewTapGestureRecognizer: UITapGestureRecognizer = {
        $0.delegate = self
        return $0
    }(UITapGestureRecognizer(target: self, action: #selector(viewTapRecognizerHandle(_:))))

    // MARK: - Managing the View

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(viewTapGestureRecognizer)
        contentViewController.automaticallyAdjustsScrollViewInsets = false
        loadSubviews()
        loadConstraints()
        contentViewController.didMove(toParent: self)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        super.viewWillDisappear(animated)
    }

    private func loadSubviews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false

        dummyView.addSubview(contentView)
        view.addSubview(dummyView)
    }

    private func loadConstraints() {
        let dummyViewMaximumHeightConstraint = traitCollection.verticalSizeClass == .compact
            ? dummyViewCompactHeightConstraint
            : dummyViewRegularHeightConstraint

        var constraints = [
            contentView.leadingAnchor.constraint(equalTo: dummyView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: dummyView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: dummyView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: dummyView.bottomAnchor),
        ]

        constraints += [
            dummyViewMaximumHeightConstraint,
            dummyViewBottomConstraint,
            dummyViewLeadingConstraint,
            self.dummyView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
            dummyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dummyView.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.maximumWidth),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Configuring the View’s Layout Behavior

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixRoundCorners()
    }

    private func fixRoundCorners() {
        let size = CGSize(width: dummyView.bounds.width, height: view.bounds.height)
        let layerFrame = CGRect(origin: .zero, size: size)
        maskLayer.frame = layerFrame
        let bezierPath = UIBezierPath(roundedRect: layerFrame,
                                      byRoundingCorners: [.topLeft, .topRight],
                                      cornerRadii: CGSize(width: 12, height: 12))
        maskLayer.path = bezierPath.cgPath
    }

    // MARK: - Responding to a Change in the Interface Environment

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            switch previousTraitCollection?.verticalSizeClass {
            case .compact?:
                dummyViewCompactHeightConstraint.isActive = false
            case .regular?:
                dummyViewRegularHeightConstraint.isActive = false
            default:
                break
            }

            switch traitCollection.verticalSizeClass {
            case .compact:
                dummyViewCompactHeightConstraint.isActive = true
            case .regular:
                dummyViewRegularHeightConstraint.isActive = true
            default:
                break
            }
        }
    }

    // MARK: - Actions

    @objc
    func viewTapRecognizerHandle(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == .recognized else { return }
        delegate?.actionSheetTemplateDidFinish(self)
    }

    @objc
    func panRecognizerHandle(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: contentView)
        let newY = min(max(view.frame.minY + translation.y, 0), view.frame.maxY)
        let progress = newY / contentView.bounds.height

        switch sender.state {
        case .ended where sender.velocity(in: view).y >= Constants.maxVelocity || progress > Constants.percentThreshold:
            delegate?.actionSheetTemplateDidFinish(self)
        case .ended:
            UIView.animate(withDuration: Constants.defaultAnimationDuration) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.view.frame.origin.y = 0
            }
        default:
            view.frame.origin.y = newY
        }
        sender.setTranslation(.zero, in: view)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ActionSheetTemplate: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard gestureRecognizer === viewTapGestureRecognizer else { return true }
        return touch.view?.isDescendant(of: contentView) == false
    }
}

// MARK: - Constants

private extension ActionSheetTemplate {
    enum Constants {
        static let maximumWidth: CGFloat = 414
        static let compactHeightMultiplier: CGFloat = 0.9
        static let regularHeightMultiplier: CGFloat = 0.8
        static let maxVelocity: CGFloat = 50
        static let percentThreshold: CGFloat = 0.3
        static let defaultAnimationDuration: TimeInterval = 0.3
    }
}
