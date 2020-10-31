import UIKit

final class SuccessScreenViewController: UIViewController {

    // MARK: - VIPER

    var output: SuccessScreenViewOutput!

    // MARK: - Data
    
    var confettiTypes: [ConfettiType] = {
        let confettiColors = [
            (r:149,g:58,b:255), (r:255,g:195,b:41), (r:255,g:101,b:26),
            (r:123,g:92,b:255), (r:76,g:126,b:255), (r:71,g:192,b:255),
            (r:255,g:47,b:39), (r:255,g:91,b:134), (r:233,g:122,b:208)
        ].map {
            UIColor(red: $0.r / 255.0, green: $0.g / 255.0, blue: $0.b / 255.0, alpha: 1)
        }

        return [
            ConfettiPosition.foreground,
            ConfettiPosition.background
        ].flatMap { position in
            return [
                ConfettiShape.rectangle,
                ConfettiShape.circle
            ].flatMap { shape in
                return confettiColors.map { color in
                    return ConfettiType(
                        color: color,
                        shape: shape,
                        position: position
                    )
                }
            }
        }
    }()

    // MARK: - Initializing

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - UI properties
    
    private lazy var treasureImageView: UIImageView = {
        $0.image = UIImage.Styles.successQuestTreasure
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var successTitleLabel: UILabel = {
        $0.textAlignment = .center
        $0.text = "Поздравляем!"
        $0.font = UIFont.Styles.title8
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var successSubtitleLabel: UILabel = {
        $0.textAlignment = .center
        $0.text = "Вы выиграли 1500₽"
        $0.font = UIFont.Styles.title
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var giftImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 70
        return $0
    }(UIImageView())
    
    private lazy var shareButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Поделиться",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
//        $0.addTarget(self, action: #selector(didPressSubmitButton), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.Styles.white
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            treasureImageView,
            successTitleLabel,
            successSubtitleLabel,
            giftImageView,
            shareButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        let viewTopAnchor: NSLayoutYAxisAnchor
        let viewBottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            viewTopAnchor = view.safeAreaLayoutGuide.topAnchor
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewTopAnchor = topLayoutGuide.bottomAnchor
            viewBottomAnchor = bottomLayoutGuide.topAnchor
        }
        let constraints = [
            treasureImageView.topAnchor.constraint(equalTo: viewTopAnchor, constant: 128),
            treasureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            treasureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            treasureImageView.heightAnchor.constraint(equalTo: treasureImageView.widthAnchor),
            
            successTitleLabel.topAnchor.constraint(equalTo: treasureImageView.bottomAnchor, constant: 64),
            successTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            successSubtitleLabel.topAnchor.constraint(equalTo: successTitleLabel.bottomAnchor, constant: 16),
            successSubtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            giftImageView.topAnchor.constraint(equalTo: successSubtitleLabel.bottomAnchor, constant: 12),
            giftImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            giftImageView.widthAnchor.constraint(equalToConstant: 140),
            giftImageView.heightAnchor.constraint(equalToConstant: 140),
            
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shareButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
}

// MARK: - SuccessScreenViewInput

extension SuccessScreenViewController: SuccessScreenViewInput {
    func setupGift(_ gift: QuestGift) {
        successSubtitleLabel.text = "Вы выиграли \(gift.title)"
        if let photo = gift.photo {
            giftImageView.image = photo
        } else {
            if let photoUrl = gift.photoUrl,
               let url = URL(string: photoUrl) {
                if let image = ImageCache.shared()[url] {
                    giftImageView.image = image
                } else {
                    giftImageView.load(
                        avatarUrl: photoUrl,
                        placeholder: UIImage()
                    ) { [weak self] image, _ in
                        ImageCache.shared()[url] = image
                        self?.giftImageView.image = image
                    }
                }
            }
        }
    }
    
    func runConfetti() {
        let foregroundConfettiLayer = createConfettiLayer()

        let backgroundConfettiLayer: CAEmitterLayer = {
            let emitterLayer = createConfettiLayer()
            
            for emitterCell in emitterLayer.emitterCells ?? [] {
                emitterCell.scale = 0.5
            }

            emitterLayer.opacity = 0.5
            emitterLayer.speed = 0.95
            
            return emitterLayer
        }()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            [
                foregroundConfettiLayer,
                backgroundConfettiLayer,
            ].forEach {
                self.view.layer.addSublayer($0)
                self.addBehaviors(to: $0)
                self.addAnimations(to: $0)
            }
        }
    }
}

// MARK: - SuccessScreenTransitionHandler

extension SuccessScreenViewController: SuccessScreenTransitionHandler { }

// MARK: - Confetti

extension SuccessScreenViewController {
    func createConfettiCells() -> [CAEmitterCell] {
        return confettiTypes.map { confettiType in
            let cell = CAEmitterCell()
            cell.name = confettiType.name
            
            cell.beginTime = 0.1
            cell.birthRate = 100
            cell.contents = confettiType.image.cgImage
            cell.emissionRange = CGFloat(Double.pi)
            cell.lifetime = 10
            cell.spin = 4
            cell.spinRange = 8
            cell.velocityRange = 0
            cell.yAcceleration = 0
            
            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")
            
            return cell
        }
    }

    func createBehavior(type: String) -> NSObject {
        let behaviorClass = NSClassFromString("CAEmitterBehavior") as! NSObject.Type
        let behaviorWithType = behaviorClass.method(for: NSSelectorFromString("behaviorWithType:"))!
        let castedBehaviorWithType = unsafeBitCast(behaviorWithType, to:(@convention(c)(Any?, Selector, Any?) -> NSObject).self)
        return castedBehaviorWithType(behaviorClass, NSSelectorFromString("behaviorWithType:"), type)
    }

    func horizontalWaveBehavior() -> Any {
        let behavior = createBehavior(type: "wave")
        behavior.setValue([100, 0, 0], forKeyPath: "force")
        behavior.setValue(0.5, forKeyPath: "frequency")
        return behavior
    }

    func verticalWaveBehavior() -> Any {
        let behavior = createBehavior(type: "wave")
        behavior.setValue([0, 500, 0], forKeyPath: "force")
        behavior.setValue(3, forKeyPath: "frequency")
        return behavior
    }

    func attractorBehavior(for emitterLayer: CAEmitterLayer) -> Any {
        let behavior = createBehavior(type: "attractor")
        behavior.setValue("attractor", forKeyPath: "name")

        behavior.setValue(-290, forKeyPath: "falloff")
        behavior.setValue(300, forKeyPath: "radius")
        behavior.setValue(10, forKeyPath: "stiffness")

        behavior.setValue(CGPoint(x: emitterLayer.emitterPosition.x,
                                  y: emitterLayer.emitterPosition.y + 20),
                          forKeyPath: "position")
        behavior.setValue(-70, forKeyPath: "zPosition")

        return behavior
    }

    func addBehaviors(to layer: CAEmitterLayer) {
        layer.setValue([
            horizontalWaveBehavior(),
            verticalWaveBehavior(),
            attractorBehavior(for: layer)
        ], forKey: "emitterBehaviors")
    }

    func addAttractorAnimation(to layer: CALayer) {
        let animation = CAKeyframeAnimation()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 3
        animation.keyTimes = [0, 0.4]
        animation.values = [80, 5]

        layer.add(animation, forKey: "emitterBehaviors.attractor.stiffness")
    }

    func addBirthrateAnimation(to layer: CALayer) {
        let animation = CABasicAnimation()
        animation.duration = 1
        animation.fromValue = 1
        animation.toValue = 0

        layer.add(animation, forKey: "birthRate")
    }

    func addAnimations(to layer: CAEmitterLayer) {
        addAttractorAnimation(to: layer)
        addBirthrateAnimation(to: layer)
        addGravityAnimation(to: layer)
    }

    func dragBehavior() -> Any {
        let behavior = createBehavior(type: "drag")
        behavior.setValue("drag", forKey: "name")
        behavior.setValue(2, forKey: "drag")

        return behavior
    }

    func addDragAnimation(to layer: CALayer) {
        let animation = CABasicAnimation()
        animation.duration = 0.35
        animation.fromValue = 0
        animation.toValue = 2

        layer.add(animation, forKey:  "emitterBehaviors.drag.drag")
    }

    func addGravityAnimation(to layer: CALayer) {
        let animation = CAKeyframeAnimation()
        animation.duration = 6
        animation.keyTimes = [0.05, 0.1, 0.5, 1]
        animation.values = [0, 100, 2000, 4000]

        for image in confettiTypes {
            layer.add(animation, forKey: "emitterCells.\(image.name).yAcceleration")
        }
    }

    func createConfettiLayer() -> CAEmitterLayer {
       let emitterLayer = CAEmitterLayer()

        emitterLayer.birthRate = 0
        emitterLayer.emitterCells = createConfettiCells()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.minY - 100)
        emitterLayer.emitterSize = CGSize(width: 100, height: 100)
        emitterLayer.emitterShape = .sphere
        emitterLayer.frame = view.bounds

        emitterLayer.beginTime = CACurrentMediaTime()
        return emitterLayer
    }
}

// MARK: - Localization

private extension SuccessScreenViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension SuccessScreenViewController {
    enum Constants { }
}
