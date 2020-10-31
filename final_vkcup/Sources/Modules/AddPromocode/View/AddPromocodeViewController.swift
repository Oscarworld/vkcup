import UIKit

final class AddPromocodeViewController: UIViewController {

    // MARK: - VIPER

    var output: AddPromocodeViewOutput!

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
            string: "Промокод",
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
    
    private lazy var valueView: UIView = {
        return $0
    }(UIView())
    
    private lazy var valueLabel: UILabel = {
        $0.text = "Промокод"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var valueTextField: TextField = {
        $0.placeholder = "Введите промокод"
        return $0
    }(TextField())
    
    private lazy var createButton: UIButton = {
        let attributedString = NSAttributedString(
            string: "Сохранить",
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
            valueLabel,
            valueTextField,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            valueView.addSubview($0)
        }
        
        [
            titleView,
            descriptionView,
            valueView,
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
            
            valueLabel.topAnchor.constraint(equalTo: valueView.topAnchor, constant: 12),
            valueLabel.leadingAnchor.constraint(equalTo: valueView.leadingAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(equalTo: valueView.trailingAnchor, constant: -12),
            
            valueTextField.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8),
            valueTextField.leadingAnchor.constraint(equalTo: valueView.leadingAnchor, constant: 12),
            valueTextField.trailingAnchor.constraint(equalTo: valueView.trailingAnchor, constant: -12),
            valueTextField.bottomAnchor.constraint(equalTo: valueView.bottomAnchor, constant: -12),
            valueTextField.heightAnchor.constraint(equalToConstant: 44),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            createButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressCreateButton() {
        output.didHandleAddPromocode(
            title: titleTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            value: valueTextField.text ?? ""
        )
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AddPromocodeViewInput

extension AddPromocodeViewController: AddPromocodeViewInput { }

// MARK: - AddPromocodeTransitionHandler

extension AddPromocodeViewController: AddPromocodeTransitionHandler { }

// MARK: - Localization

private extension AddPromocodeViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddPromocodeViewController {
    enum Constants { }
}
