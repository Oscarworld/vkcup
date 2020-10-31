import UIKit

final class SelectActionSheetViewController: UIViewController {

    // MARK: - VIPER

    var output: SelectActionSheetViewOutput!
    
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
    
    private lazy var titleView: UIView = {
        $0.backgroundColor = UIColor.clear
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.Styles.title1
        $0.textColor = UIColor.Styles.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var closeButton: UIButton = {
        $0.setImage(UIImage.Styles.close, for: .normal)
        $0.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        $0.imageView?.contentMode = .scaleAspectFit
        return $0
    }(UIButton())
    
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
            SelectCell.self,
            forCellReuseIdentifier: cellReuseIdentifier
        )
        view.tableFooterView = UIView()
        return view
    }()
    
    // MARK: - Dynamics constraints
    
    fileprivate lazy var tableViewHeightConstraint: NSLayoutConstraint = {
        $0.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        return $0
    }(self.tableView.heightAnchor.constraint(equalToConstant: 0))

    // MARK: - Managing the View

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.clear
        setupView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
            titleView,
            tableView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            titleLabel,
            closeButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            titleView.addSubview($0)
        }
    }

    private func setupConstraints() {
        let constraints = [
            tableViewHeightConstraint,
            titleView.heightAnchor.constraint(equalToConstant: 52),
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            closeButton.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 2),
            closeButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -2),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
    private func didPressCloseButton() {
        output.didPressCloseButton()
    }
}

// MARK: - SelectActionSheetViewInput

extension SelectActionSheetViewController: SelectActionSheetViewInput {
    func setupTitle(
        _ title: String
    ) {
        titleLabel.text = title
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SelectActionSheetViewController: UITableViewDataSource {
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
        ) as? SelectCell else {
            assertionFailure("CityCell should be at \(indexPath)")
            return .init()
        }
        
        cell.title = viewModel.title
        cell.checkmarkImageView.isHidden = output.getSelectedViewModel() != viewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectActionSheetViewController: UITableViewDelegate {
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

// MARK: - SelectActionSheetTransitionHandler

extension SelectActionSheetViewController: SelectActionSheetTransitionHandler { }

// MARK: - Constants

private extension SelectActionSheetViewController {
    enum Constants {
        static let rowHeight: CGFloat = 48
    }
}
