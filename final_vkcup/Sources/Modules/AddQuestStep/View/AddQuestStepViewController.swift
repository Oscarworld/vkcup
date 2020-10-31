import UIKit

final class AddQuestStepViewController: UIViewController {

    // MARK: - VIPER

    var output: AddQuestStepViewOutput!

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
    
    private lazy var headerView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        return $0
    }(UIView())
    
    private lazy var headerBottomBorder: UIView = {
        $0.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.15)
        return $0
    }(UIView())
    
    private lazy var titleButton: UIButton = {
        $0.backgroundColor = UIColor.Styles.white
        $0.imageEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceRightToLeft
        let attributedString = NSAttributedString(
            string: "Задание",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.black
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        return $0
    }(UIButton())
    
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
        return $0
    }(UIView())
    
    private lazy var selectImageView: UIView = {
        return $0
    }(UIView())
    
    private lazy var questImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var selectImageTitleLabel: UILabel = {
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.title
        $0.textColor = UIColor.Styles.black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "Фотография для задания"
        return $0
    }(UILabel())
    
    private lazy var setlectImageSubtitleLabel: UILabel = {
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.subtitle
        $0.textColor = UIColor.Styles.gray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "По этой фотографии участники будут отгадывать задание"
        return $0
    }(UILabel())
    
    private lazy var selectImageButton: UIButton = {
        $0.backgroundColor = UIColor.Styles.white
        let attributedString = NSAttributedString(
            string: "Выбрать фото",
            attributes: [
                .font: UIFont.Styles.title9,
                .foregroundColor: UIColor.Styles.white,
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(didPressSelectImage), for: .touchUpInside)
        $0.backgroundColor = UIColor.Styles.primary
        $0.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    private lazy var locationView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressLocationView))
        $0.addGestureRecognizer(tap)
        return $0
    }(UIView())
    
    private lazy var locationLabel: UILabel = {
        $0.text = "Локация"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var locationTextField: TextField = {
        $0.placeholder = "Выберите локацию"
        let rightView = UIImageView()
        rightView.image = UIImage.Styles.dropdown
        rightView.contentMode = .scaleAspectFit
        $0.rightView = rightView
        $0.rightViewMode = .always
        $0.isUserInteractionEnabled = false
        $0.padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 26)
        return $0
    }(TextField())
    
    private lazy var titleView: UIView = {
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
    
    private lazy var locationRangeView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.isHidden = true
        return $0
    }(UIView())
    
    private lazy var locationRangeLabel: UILabel = {
        $0.text = "Область поиска: 10 м."
        $0.font = UIFont.Styles.subtitle2
        $0.textColor = UIColor.Styles.black
        return $0
    }(UILabel())
    
    private lazy var locationRangeSlider: UISlider = {
        $0.minimumTrackTintColor = UIColor.Styles.second
        $0.thumbTintColor = UIColor.Styles.white
        $0.minimumValue = 0
        $0.maximumValue = 1000
        $0.setValue(10, animated: false)
        $0.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        return $0
    }(UISlider())
    
    private lazy var locationRangeDescriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.text = "Участники будут видеть только область поиска. Чем больше область поиска, тем сложнее задание."
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var qrcodeView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.isHidden = true
        return $0
    }(UIView())
    
    private lazy var qrcodeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = generateQRCode(from: "vkquest://quest/1")
        return $0
    }(UIImageView())
    
    private lazy var questionView: UIView = {
        $0.backgroundColor = UIColor.Styles.white
        $0.isHidden = true
        return $0
    }(UIView())
    
    private lazy var questionLabel: UILabel = {
        $0.text = "Вопрос"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var questionTextField: TextField = {
        $0.placeholder = "Введите вопрос"
        return $0
    }(TextField())
    
    private lazy var answerLabel: UILabel = {
        $0.text = "Ответ"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var answerTextField: TextField = {
        $0.placeholder = "Введите ответ"
        return $0
    }(TextField())
    
    private lazy var createButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Создать",
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
        view.backgroundColor = UIColor.Styles.white
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        output.setupView()
    }

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            titleButton,
            headerBottomBorder,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }
        
        [
            headerView,
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
            selectImageTitleLabel,
            setlectImageSubtitleLabel,
            selectImageButton,
            questImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            selectImageView.addSubview($0)
        }
        
        [
            locationLabel,
            locationTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            locationView.addSubview($0)
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
            locationRangeLabel,
            locationRangeSlider,
            locationRangeDescriptionLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            locationRangeView.addSubview($0)
        }
        
        [
            qrcodeImageView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            qrcodeView.addSubview($0)
        }
        
        [
            questionLabel,
            questionTextField,
            answerLabel,
            answerTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            questionView.addSubview($0)
        }
        
        [
            selectImageView,
            locationView,
            titleView,
            descriptionView,
            typeView,
            locationRangeView,
            qrcodeView,
            questionView,
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
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleButton.topAnchor.constraint(equalTo: viewTopAnchor, constant: 12),
            titleButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            
            headerBottomBorder.heightAnchor.constraint(equalToConstant: 0.5),
            headerBottomBorder.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerBottomBorder.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerBottomBorder.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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
            
            questImageView.topAnchor.constraint(equalTo: selectImageView.topAnchor),
            questImageView.leadingAnchor.constraint(equalTo: selectImageView.leadingAnchor),
            questImageView.trailingAnchor.constraint(equalTo: selectImageView.trailingAnchor),
            questImageView.bottomAnchor.constraint(equalTo: selectImageView.bottomAnchor),
            questImageView.heightAnchor.constraint(equalToConstant: 240),
            
            selectImageTitleLabel.topAnchor.constraint(equalTo: selectImageView.topAnchor, constant: 64),
            selectImageTitleLabel.leadingAnchor.constraint(equalTo: selectImageView.leadingAnchor, constant: 32),
            selectImageTitleLabel.trailingAnchor.constraint(equalTo: selectImageView.trailingAnchor, constant: -32),
            
            setlectImageSubtitleLabel.topAnchor.constraint(equalTo: selectImageTitleLabel.bottomAnchor, constant: 8),
            setlectImageSubtitleLabel.leadingAnchor.constraint(equalTo: selectImageView.leadingAnchor, constant: 32),
            setlectImageSubtitleLabel.trailingAnchor.constraint(equalTo: selectImageView.trailingAnchor, constant: -32),
            
            selectImageButton.topAnchor.constraint(equalTo: setlectImageSubtitleLabel.bottomAnchor, constant: 24),
            selectImageButton.centerXAnchor.constraint(equalTo: selectImageView.centerXAnchor),
            selectImageButton.widthAnchor.constraint(equalToConstant: 136),
            selectImageButton.heightAnchor.constraint(equalToConstant: 36),
            
            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 12),
            locationLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -12),
            
            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            locationTextField.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 12),
            locationTextField.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -12),
            locationTextField.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -12),
            locationTextField.heightAnchor.constraint(equalToConstant: 44),
            
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
            
            locationRangeLabel.topAnchor.constraint(equalTo: locationRangeView.topAnchor, constant: 12),
            locationRangeLabel.leadingAnchor.constraint(equalTo: locationRangeView.leadingAnchor, constant: 12),
            locationRangeLabel.trailingAnchor.constraint(equalTo: locationRangeView.trailingAnchor, constant: -12),
            
            locationRangeSlider.topAnchor.constraint(equalTo: locationRangeLabel.bottomAnchor, constant: 8),
            locationRangeSlider.leadingAnchor.constraint(equalTo: locationRangeView.leadingAnchor, constant: 12),
            locationRangeSlider.trailingAnchor.constraint(equalTo: locationRangeView.trailingAnchor, constant: -12),
            
            locationRangeDescriptionLabel.topAnchor.constraint(equalTo: locationRangeSlider.bottomAnchor, constant: 8),
            locationRangeDescriptionLabel.leadingAnchor.constraint(equalTo: locationRangeView.leadingAnchor, constant: 12),
            locationRangeDescriptionLabel.trailingAnchor.constraint(equalTo: locationRangeView.trailingAnchor, constant: -12),
            locationRangeDescriptionLabel.bottomAnchor.constraint(equalTo: locationRangeView.bottomAnchor, constant: -12),
            
            qrcodeImageView.topAnchor.constraint(equalTo: qrcodeView.topAnchor, constant: 12),
            qrcodeImageView.leadingAnchor.constraint(equalTo: qrcodeView.leadingAnchor, constant: 12),
            qrcodeImageView.trailingAnchor.constraint(equalTo: qrcodeView.trailingAnchor, constant: -12),
            qrcodeImageView.bottomAnchor.constraint(equalTo: qrcodeView.bottomAnchor, constant: -12),
            qrcodeImageView.heightAnchor.constraint(equalTo: qrcodeImageView.widthAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 12),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 12),
            questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -12),
            
            questionTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
            questionTextField.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 12),
            questionTextField.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -12),
            questionTextField.heightAnchor.constraint(equalToConstant: 44),
            
            answerLabel.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 12),
            answerLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 12),
            answerLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -12),
            
            answerTextField.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 8),
            answerTextField.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 12),
            answerTextField.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -12),
            answerTextField.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -12),
            answerTextField.heightAnchor.constraint(equalToConstant: 44),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            createButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if scrollView.contentInset.bottom == 0 {
                scrollView.contentInset.bottom += keyboardSize.height
            }
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        if scrollView.contentInset.bottom != 0 {
            scrollView.contentInset.bottom = 0
        }
    }
    
    @objc
    private func didPressCreateButton() {
        output.didHandleCreateStep(
            image: questImageView.image,
            title: titleTextField.text,
            description: locationTextField.text
        )
    }
    
    @objc
    private func didPressTypeView() {
        output.didHandleType()
    }
    
    @objc
    private func didPressLocationView() {
        output.didHandleLocation()
    }
    
    @objc
    private func didPressSelectImage() {
        output.didHandleAddImage()
    }
    
    @objc
    private func sliderValueDidChange(_ sender: UISlider!) {
        locationRangeLabel.text = "Область поиска: \(Int(sender.value)) м."
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

// MARK: - AddQuestStepViewInput

extension AddQuestStepViewController: AddQuestStepViewInput {
    func setupQuestType(item: SelectViewModel) {
        typeTextField.text = item.title
        UIView.animate(withDuration: 0.3) {
            self.locationRangeView.isHidden = item.id != 0
            self.qrcodeView.isHidden = item.id != 1
            self.questionView.isHidden = item.id != 2
        }
    }
    
    func setupLocation(
        address: String
    ) {
        locationTextField.text = address
    }
    
    func setupImage(_ image: UIImage) {
        questImageView.image = image
    }
}

// MARK: - AddQuestStepTransitionHandler

extension AddQuestStepViewController: AddQuestStepTransitionHandler { }

// MARK: - Localization

private extension AddQuestStepViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddQuestStepViewController {
    enum Constants { }
}
