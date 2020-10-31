import UIKit

final class AddMoneyViewController: UIViewController {

    // MARK: - VIPER

    var output: AddMoneyViewOutput!

    // MARK: - Data
    
    private let cellReuseIdentifier = "tableCell"
    private var cellHeights: [IndexPath: CGFloat] = [:]

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
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Сумма"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var titleTextField: TextField = {
        $0.placeholder = "Введите сумму"
        $0.keyboardType = .decimalPad
        return $0
    }(TextField())
    
    private lazy var giftsLabel: UILabel = {
        $0.text = "Откуда списать"
        $0.font = UIFont.Styles.subtitle1
        $0.textColor = UIColor.Styles.gray
        return $0
    }(UILabel())
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = UIColor.Styles.white
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.estimatedRowHeight = Constants.rowHeight
        view.separatorStyle = .none
        view.register(
            MoneyCell.self,
            forCellReuseIdentifier: cellReuseIdentifier
        )
        view.tableFooterView = UIView()
        return view
    }()
    
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
    
    // MARK: - Dynamics constraints
    
    fileprivate lazy var tableViewHeightConstraint: NSLayoutConstraint = {
        $0.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        return $0
    }(self.tableView.heightAnchor.constraint(equalToConstant: 0))

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.setupScrollViewHeight()
        }
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
            titleLabel,
            titleTextField,
            giftsLabel,
            tableView,
            createButton,
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
            
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            giftsLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            giftsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            giftsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            tableView.topAnchor.constraint(equalTo: giftsLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: 12),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -12),
            createButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupScrollViewHeight() {
        guard let window = view.window else { return }
        
        let tableViewContentHeight = tableView.contentSize.height
            + UIScreen.safeAreaInsets.bottom
        let tableViewHeight = min(tableViewContentHeight, window.frame.height)
        
        if tableViewHeightConstraint.constant != tableViewHeight {
            tableViewHeightConstraint.constant = tableViewHeight
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }

    // MARK: - Action
    
    @objc
    private func didPressCreateButton() {
        output.didHandleAddMoney(
            value: "\(titleTextField.text ?? "") ₽"
        )
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AddMoneyViewInput

extension AddMoneyViewController: AddMoneyViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension AddMoneyViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.numberOfItems()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let viewModel = output.getViewModel(in: indexPath),
              let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdentifier,
            for: indexPath
        ) as? MoneyCell else {
            assertionFailure("CityCell should be at \(indexPath)")
            return .init()
        }
        
        cell.title = viewModel.title
        cell.checkmarkImageView.image = output.getSelectedViewModel() != viewModel
            ? UIImage.Styles.radioOff
            : UIImage.Styles.radioOn
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AddMoneyViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        output.didSelectCell(at: indexPath)
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        cellHeights[indexPath] = cell.frame.size.height
    }

    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return cellHeights[indexPath] ?? Constants.rowHeight
    }
}


// MARK: - AddMoneyTransitionHandler

extension AddMoneyViewController: AddMoneyTransitionHandler { }

// MARK: - Localization

private extension AddMoneyViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddMoneyViewController {
    enum Constants {
        static let rowHeight: CGFloat = 48
    }
}
