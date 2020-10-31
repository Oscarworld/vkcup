import UIKit

final class CreateQuestViewController: UIViewController {

    // MARK: - VIPER

    var output: CreateQuestViewOutput!

    // MARK: - Data

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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        $0.alwaysBounceVertical = true
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var titleView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Название"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var titleTextField: TextField = {
        $0.placeholder = "Введите название"
        return $0
    }(TextField())
    
    private lazy var descriptionView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var descriptionLabel: UILabel = {
        $0.text = "Описание"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var descriptionTextField: TextField = {
        $0.placeholder = "Введите описание"
        return $0
    }(TextField())
    
    private lazy var typeView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressTypeView))
        $0.addGestureRecognizer(tap)
        return $0
    }(UIView())
    
    private lazy var typeLabel: UILabel = {
        $0.text = "Тип"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var typeTextField: TextField = {
        $0.placeholder = "Выберите тип"
        let rightView = UIImageView()
        rightView.image = UIImage.Styles.dropdown
        rightView.contentMode = .scaleAspectFit
        $0.rightView = rightView
        $0.rightViewMode = .always
        $0.isUserInteractionEnabled = false
        return $0
    }(TextField())
    
    private lazy var onlyForMembersView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.isHidden = true
        return $0
    }(UIView())
    
    private lazy var onlyForMembersLabel: UILabel = {
        $0.text = "Только для подписчиков"
        $0.font = UIFont.Styles.title7
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var onlyForMembersSwitch: UISwitch = {
        $0.onTintColor = UIColor.Styles.second
        $0.isOn = false
        return $0
    }(UISwitch())
    
    private lazy var friendsView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.isHidden = true
        return $0
    }(UIView())
    
    private lazy var friendsLabel: UILabel = {
        $0.text = "Участники"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var friendsStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var addFriendButton: UIButton = {
        $0.setImage(UIImage.Styles.add, for:.normal)
        let attributedString = NSAttributedString(
            string: "Добавить участника",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.second
            ]
        )
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 0)
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(
            self,
            action: #selector(didPressAddFriend),
            for: .touchUpInside
        )
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Styles.second.cgColor
        return $0
    }(UIButton())
    
    private lazy var giftsView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var giftsLabel: UILabel = {
        $0.text = "Призы"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var giftsStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var addGiftButton: UIButton = {
        $0.setImage(UIImage.Styles.add, for:.normal)
        let attributedString = NSAttributedString(
            string: "Добавить приз",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.second
            ]
        )
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 0)
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(
            self,
            action: #selector(didPressAddGift),
            for: .touchUpInside
        )
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Styles.second.cgColor
        return $0
    }(UIButton())
    
    private lazy var stepsView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var stepsLabel: UILabel = {
        $0.text = "Задания"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var stepsStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var addStepButton: UIButton = {
        $0.setImage(UIImage.Styles.add, for:.normal)
        let attributedString = NSAttributedString(
            string: "Добавить задание",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.second
            ]
        )
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 0)
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(
            self,
            action: #selector(didPressAddStep),
            for: .touchUpInside
        )
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Styles.second.cgColor
        return $0
    }(UIButton())
    
    private lazy var createButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Создать квест",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(
            self,
            action: #selector(didPressCreateButton),
            for: .touchUpInside
        )
        $0.backgroundColor = UIColor.Styles.primary
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        output.setupView()
    }

    // MARK: - Setup

    private func setup() {
        navigationItem.title = "Создать квест"
        tabBarItem.title = "Создать квест"
        tabBarItem.image = UIImage.Styles.addCircleOutline
        tabBarItem.selectedImage = UIImage.Styles.addCircleOutline
    }

    private func setupView() {
        [
            scrollView,
            createButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    
        [
            contentView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        [
            stackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        [
            titleLabel,
            titleTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            titleView.addSubview($0)
        }
        
        [
            descriptionLabel,
            descriptionTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.addSubview($0)
        }
        
        [
            typeLabel,
            typeTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            typeView.addSubview($0)
        }
        
        [
            onlyForMembersLabel,
            onlyForMembersSwitch,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            onlyForMembersView.addSubview($0)
        }
        
        [
            friendsLabel,
            friendsStackView,
            addFriendButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            friendsView.addSubview($0)
        }
        
        [
            giftsLabel,
            giftsStackView,
            addGiftButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftsView.addSubview($0)
        }
        
        [
            stepsLabel,
            stepsStackView,
            addStepButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stepsView.addSubview($0)
        }
        
        [
            titleView,
            descriptionView,
            typeView,
            onlyForMembersView,
            friendsView,
            giftsView,
            stepsView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
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
            scrollView.topAnchor.constraint(equalTo: viewTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -12),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -12),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 12),
            titleTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -12),
            titleTextField.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -12),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            descriptionTextField.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),
            descriptionTextField.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -12),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 44),
            
            typeLabel.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 12),
            typeLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 12),
            typeLabel.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -12),
            
            typeTextField.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            typeTextField.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 12),
            typeTextField.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -12),
            typeTextField.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -12),
            typeTextField.heightAnchor.constraint(equalToConstant: 44),
            
            onlyForMembersLabel.topAnchor.constraint(equalTo: onlyForMembersView.topAnchor, constant: 12),
            onlyForMembersLabel.leadingAnchor.constraint(equalTo: onlyForMembersView.leadingAnchor, constant: 12),
            onlyForMembersLabel.trailingAnchor.constraint(equalTo: onlyForMembersSwitch.leadingAnchor, constant: -12),
            onlyForMembersLabel.bottomAnchor.constraint(equalTo: onlyForMembersView.bottomAnchor, constant: -12),
            
            onlyForMembersSwitch.centerYAnchor.constraint(equalTo: onlyForMembersLabel.centerYAnchor),
            onlyForMembersSwitch.trailingAnchor.constraint(equalTo: onlyForMembersView.trailingAnchor, constant: -12),
            
            friendsLabel.topAnchor.constraint(equalTo: friendsView.topAnchor, constant: 12),
            friendsLabel.leadingAnchor.constraint(equalTo: friendsView.leadingAnchor, constant: 12),
            friendsLabel.trailingAnchor.constraint(equalTo: friendsView.trailingAnchor, constant: -12),
            
            friendsStackView.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor, constant: 8),
            friendsStackView.leadingAnchor.constraint(equalTo: friendsView.leadingAnchor),
            friendsStackView.trailingAnchor.constraint(equalTo: friendsView.trailingAnchor),

            addFriendButton.topAnchor.constraint(equalTo: friendsStackView.bottomAnchor),
            addFriendButton.leadingAnchor.constraint(equalTo: friendsView.leadingAnchor, constant: 12),
            addFriendButton.bottomAnchor.constraint(equalTo: friendsView.bottomAnchor, constant: -12),
            addFriendButton.heightAnchor.constraint(equalToConstant: 40),
            addFriendButton.widthAnchor.constraint(equalToConstant: 220),
            
            giftsLabel.topAnchor.constraint(equalTo: giftsView.topAnchor, constant: 12),
            giftsLabel.leadingAnchor.constraint(equalTo: giftsView.leadingAnchor, constant: 12),
            giftsLabel.trailingAnchor.constraint(equalTo: giftsView.trailingAnchor, constant: -12),
            
            giftsStackView.topAnchor.constraint(equalTo: giftsLabel.bottomAnchor, constant: 8),
            giftsStackView.leadingAnchor.constraint(equalTo: giftsView.leadingAnchor),
            giftsStackView.trailingAnchor.constraint(equalTo: giftsView.trailingAnchor),

            addGiftButton.topAnchor.constraint(equalTo: giftsStackView.bottomAnchor),
            addGiftButton.leadingAnchor.constraint(equalTo: giftsView.leadingAnchor, constant: 12),
            addGiftButton.bottomAnchor.constraint(equalTo: giftsView.bottomAnchor, constant: -12),
            addGiftButton.heightAnchor.constraint(equalToConstant: 40),
            addGiftButton.widthAnchor.constraint(equalToConstant: 174),
            
            stepsLabel.topAnchor.constraint(equalTo: stepsView.topAnchor, constant: 12),
            stepsLabel.leadingAnchor.constraint(equalTo: stepsView.leadingAnchor, constant: 12),
            stepsLabel.trailingAnchor.constraint(equalTo: stepsView.trailingAnchor, constant: -12),
            
            stepsStackView.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor, constant: 8),
            stepsStackView.leadingAnchor.constraint(equalTo: stepsView.leadingAnchor),
            stepsStackView.trailingAnchor.constraint(equalTo: stepsView.trailingAnchor),

            addStepButton.topAnchor.constraint(equalTo: stepsStackView.bottomAnchor),
            addStepButton.leadingAnchor.constraint(equalTo: stepsView.leadingAnchor, constant: 12),
            addStepButton.bottomAnchor.constraint(equalTo: stepsView.bottomAnchor, constant: -12),
            addStepButton.heightAnchor.constraint(equalToConstant: 40),
            addStepButton.widthAnchor.constraint(equalToConstant: 202),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            createButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressTypeView() {
        output.didHandleType()
    }
    
    @objc
    private func didPressAddGift() {
        output.didHandleAddGift()
    }
    
    @objc
    private func didPressCreateButton() {
        output.didHandleCreateButton()
    }
    
    @objc
    private func didPressAddFriend() {
        output.didHandleAddFriend()
    }
    
    @objc
    private func didPressAddStep() {
        output.didHandleAddStep()
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - CreateQuestViewInput

extension CreateQuestViewController: CreateQuestViewInput {
    func setupQuestType(item: SelectViewModel) {
        typeTextField.text = item.title
        UIView.animate(withDuration: 0.3) {
            self.onlyForMembersView.isHidden = item.id != 0
            self.friendsView.isHidden = item.id != 1
        }
    }
    
    func addProduct(
        _ product: BriefProductViewModel
    ) {
        let productView = makeGiftView(
            title: product.title,
            description: product.description,
            avatar: nil,
            avatarUrl: product.avatarUrl
        )
        productView.translatesAutoresizingMaskIntoConstraints = false
        giftsStackView.addArrangedSubview(productView)
    }
    
    func addMoney(
        _ money: SelectViewModel,
        value: String
    ) {
        let moneyView = makeGiftView(
            title: money.title,
            description: value,
            avatar: UIImage.Styles.moneyOutline,
            avatarUrl: nil
        )
        moneyView.translatesAutoresizingMaskIntoConstraints = false
        giftsStackView.addArrangedSubview(moneyView)
    }
    
    func addPromocode(
        _ promocode: PromocodeViewModel
    ) {
        let productView = makeGiftView(
            title: promocode.title,
            description: promocode.description,
            avatar: UIImage.Styles.promocodeOutline,
            avatarUrl: nil
        )
        productView.translatesAutoresizingMaskIntoConstraints = false
        giftsStackView.addArrangedSubview(productView)
    }
    
    func addFriend(
        _ friend: BriefGroupViewModel
    ) {
        let friendView = makeFriendView(
            title: friend.title,
            avatarUrl: friend.avatarUrl
        )
        friendView.translatesAutoresizingMaskIntoConstraints = false
        friendsStackView.addArrangedSubview(friendView)
    }
    
    func addStep(
        image: UIImage?,
        typeImage: UIImage?,
        title: String?,
        description: String?
    ) {
        let stepView = makeStepView(
            title: title ?? "",
            description: description ?? "",
            avatar: image,
            typeImage: typeImage
        )
        stepView.translatesAutoresizingMaskIntoConstraints = false
        stepsStackView.addArrangedSubview(stepView)
    }
    
    private func makeGiftView(
        title: String,
        description: String,
        avatar: UIImage?,
        avatarUrl: String?
    ) -> UIView {
        let giftView = UIView()
        
        let giftImageView = UIImageView()
        giftImageView.contentMode = .scaleAspectFill
        giftImageView.clipsToBounds = true
        giftImageView.layer.cornerRadius = 8
        
        if let avatar = avatar {
            giftImageView.image = avatar
        } else {
            giftImageView.layer.borderWidth = 0.5
            giftImageView.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.08).cgColor
            if let productPhoto = avatarUrl,
               let url = URL(string: productPhoto ) {
                if let image = ImageCache.shared()[url] {
                    giftImageView.image = image
                } else {
                    giftImageView.load(
                        avatarUrl: productPhoto,
                        placeholder: UIImage()
                    ) { image, _ in
                        ImageCache.shared()[url] = image
                        giftImageView.image = image
                    }
                }
            }
        }
        
        let giftTitleLabel = UILabel()
        giftTitleLabel.numberOfLines = 1
        giftTitleLabel.font = UIFont.Styles.title3
        giftTitleLabel.textColor = UIColor.Styles.black
        giftTitleLabel.textAlignment = .left
        giftTitleLabel.text = title
        
        let giftDescriptionLabel = UILabel()
        giftDescriptionLabel.numberOfLines = 1
        giftDescriptionLabel.font = UIFont.Styles.subtitle2
        giftDescriptionLabel.textColor = UIColor.Styles.gray
        giftDescriptionLabel.textAlignment = .left
        giftDescriptionLabel.text = description
        
        let minusButton = UIButton()
        minusButton.setImage(UIImage.Styles.minusOutline, for: [])
        
        let counterLabel = UILabel()
        counterLabel.numberOfLines = 1
        counterLabel.font = UIFont.Styles.title3
        counterLabel.textColor = UIColor.Styles.black
        counterLabel.textAlignment = .center
        counterLabel.text = "1"
        
        let plusButton = UIButton()
        plusButton.setImage(UIImage.Styles.plusOutline, for: [])
        
        [
            giftImageView,
            giftTitleLabel,
            giftDescriptionLabel,
            minusButton,
            counterLabel,
            plusButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftView.addSubview($0)
        }
        
        giftTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        giftDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let constraints = [
            giftImageView.widthAnchor.constraint(equalToConstant: 48),
            giftImageView.heightAnchor.constraint(equalToConstant: 48),
            giftImageView.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 6),
            giftImageView.leadingAnchor.constraint(equalTo: giftView.leadingAnchor, constant: 12),
            giftImageView.bottomAnchor.constraint(equalTo: giftView.bottomAnchor, constant: -12),
            
            giftTitleLabel.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 10),
            giftTitleLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftTitleLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -12),
            
            giftDescriptionLabel.topAnchor.constraint(equalTo: giftTitleLabel.bottomAnchor, constant: 3),
            giftDescriptionLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftDescriptionLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -12),
            
            minusButton.centerYAnchor.constraint(equalTo: giftImageView.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 28),
            minusButton.heightAnchor.constraint(equalToConstant: 28),
            
            counterLabel.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            counterLabel.widthAnchor.constraint(equalToConstant: 36),
            
            plusButton.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 28),
            plusButton.heightAnchor.constraint(equalToConstant: 28),
            plusButton.trailingAnchor.constraint(equalTo: giftView.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
        
        return giftView
    }
    
    private func makeFriendView(
        title: String,
        avatarUrl: String?
    ) -> UIView {
        let giftView = UIView()
        
        let giftImageView = UIImageView()
        giftImageView.contentMode = .scaleAspectFill
        giftImageView.clipsToBounds = true
        giftImageView.layer.cornerRadius = 24
        giftImageView.layer.borderWidth = 0.5
        giftImageView.layer.borderColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.08).cgColor
        if let productPhoto = avatarUrl,
           let url = URL(string: productPhoto ) {
            if let image = ImageCache.shared()[url] {
                giftImageView.image = image
            } else {
                giftImageView.load(
                    avatarUrl: productPhoto,
                    placeholder: UIImage()
                ) { image, _ in
                    ImageCache.shared()[url] = image
                    giftImageView.image = image
                }
            }
        }
        
        let giftTitleLabel = UILabel()
        giftTitleLabel.numberOfLines = 1
        giftTitleLabel.font = UIFont.Styles.title2
        giftTitleLabel.textColor = UIColor.Styles.black
        giftTitleLabel.textAlignment = .left
        giftTitleLabel.text = title
        
        [
            giftImageView,
            giftTitleLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftView.addSubview($0)
        }
        
        let constraints = [
            giftImageView.widthAnchor.constraint(equalToConstant: 48),
            giftImageView.heightAnchor.constraint(equalToConstant: 48),
            giftImageView.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 6),
            giftImageView.leadingAnchor.constraint(equalTo: giftView.leadingAnchor, constant: 12),
            giftImageView.bottomAnchor.constraint(equalTo: giftView.bottomAnchor, constant: -12),
            
            giftTitleLabel.centerYAnchor.constraint(equalTo: giftView.centerYAnchor),
            giftTitleLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftTitleLabel.trailingAnchor.constraint(equalTo: giftView.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
        
        return giftView
    }
    
    private func makeStepView(
        title: String,
        description: String,
        avatar: UIImage?,
        typeImage: UIImage?
    ) -> UIView {
        let giftView = UIView()
        
        let giftImageView = UIImageView()
        giftImageView.contentMode = .scaleAspectFill
        giftImageView.clipsToBounds = true
        giftImageView.layer.cornerRadius = 8
        giftImageView.image = avatar
        
        let giftTitleLabel = UILabel()
        giftTitleLabel.numberOfLines = 1
        giftTitleLabel.font = UIFont.Styles.title3
        giftTitleLabel.textColor = UIColor.Styles.black
        giftTitleLabel.textAlignment = .left
        giftTitleLabel.text = title
        
        let giftDescriptionLabel = UILabel()
        giftDescriptionLabel.numberOfLines = 1
        giftDescriptionLabel.font = UIFont.Styles.subtitle2
        giftDescriptionLabel.textColor = UIColor.Styles.gray
        giftDescriptionLabel.textAlignment = .left
        giftDescriptionLabel.text = description
        
        let stepTypeImageView = UIImageView()
        stepTypeImageView.contentMode = .scaleAspectFit
        stepTypeImageView.image = typeImage
        
        [
            giftImageView,
            giftTitleLabel,
            giftDescriptionLabel,
            stepTypeImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            giftView.addSubview($0)
        }
        
        let constraints = [
            giftImageView.widthAnchor.constraint(equalToConstant: 48),
            giftImageView.heightAnchor.constraint(equalToConstant: 48),
            giftImageView.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 6),
            giftImageView.leadingAnchor.constraint(equalTo: giftView.leadingAnchor, constant: 12),
            giftImageView.bottomAnchor.constraint(equalTo: giftView.bottomAnchor, constant: -12),
            
            giftTitleLabel.topAnchor.constraint(equalTo: giftView.topAnchor, constant: 10),
            giftTitleLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftTitleLabel.trailingAnchor.constraint(equalTo: stepTypeImageView.leadingAnchor, constant: -12),
            
            giftDescriptionLabel.topAnchor.constraint(equalTo: giftTitleLabel.bottomAnchor, constant: 3),
            giftDescriptionLabel.leadingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 12),
            giftDescriptionLabel.trailingAnchor.constraint(equalTo: stepTypeImageView.leadingAnchor, constant: -12),
            
            stepTypeImageView.heightAnchor.constraint(equalToConstant: 28),
            stepTypeImageView.widthAnchor.constraint(equalToConstant: 28),
            stepTypeImageView.centerYAnchor.constraint(equalTo: giftView.centerYAnchor),
            stepTypeImageView.trailingAnchor.constraint(equalTo: giftView.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(constraints)
        
        return giftView
    }
}

// MARK: - CreateQuestTransitionHandler

extension CreateQuestViewController: CreateQuestTransitionHandler { }

// MARK: - Localization

private extension CreateQuestViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension CreateQuestViewController {
    enum Constants { }
}
