import UIKit

final class AddFriendViewController: UIViewController {

    // MARK: - VIPER

    var output: AddFriendViewOutput!

    // MARK: - Data
    
    private let footerReuseIdentifier = "tableFooter"
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

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var footerActivityIndicator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var refreshControl: UIRefreshControl = {
        $0.addTarget(
            self,
            action: #selector(refreshControlValueChanged(_:)),
            for: .valueChanged
        )
        return $0
    }(UIRefreshControl())
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.refreshControl = refreshControl
        view.backgroundColor = UIColor.Styles.white
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.estimatedRowHeight = Constants.rowHeight
        view.separatorStyle = .none
        view.register(
            GroupCell.self,
            forCellReuseIdentifier: cellReuseIdentifier
        )
        view.register(
            PaginationIndicatorView.self,
            forCellReuseIdentifier: footerReuseIdentifier
        )
        view.tableFooterView = UIView()
        return view
    }()
    
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
            string: "Друзья",
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.black
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        return $0
    }(UIButton())
    
    private lazy var errorFooterView: UILabel = {
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.backgroundColor = UIColor.Styles.white
        $0.font = UIFont.Styles.subtitle5
        $0.textColor = UIColor.Styles.gray
        $0.text = Localized.PaginationError.text
        return $0
    }(UILabel())
    
    // MARK: - Placeholder
    
    private lazy var placeholderView: PlaceholderView = {
        return $0
    }(PlaceholderView())
    
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

    // MARK: - Setup

    private func setup() { }

    private func setupView() {
        [
            tableView,
            activityIndicator,
            placeholderView,
            headerView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            titleButton,
            headerBottomBorder,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview($0)
        }
    }

    private func setupConstraints() {
        let viewTopAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            viewTopAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            viewTopAnchor = topLayoutGuide.bottomAnchor
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
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            placeholderView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func refreshControlValueChanged(
        _ sender: UIRefreshControl
    ) {
        if sender.isRefreshing {
            output.refreshDidPull()
        }
    }
}

// MARK: - AddFriendViewInput

extension AddFriendViewController: AddFriendViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func insertItems(
        _ indexPaths: [IndexPath]
    ) {
        if #available(iOS 11.0, *) {
            tableView.performBatchUpdates({
                tableView.insertRows(at: indexPaths, with: .none)
            })
        } else {
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .none)
            tableView.endUpdates()
        }
    }
    
    func endRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func showPlaceholder(
        _ state: AddFriendPlaceholderState
    ) {
        switch state {
        case .emptyList:
            placeholderView.title = Localized.Placeholder.EmptyState.title
            placeholderView.subtitle = Localized.Placeholder.EmptyState.subtitle
            placeholderView.action = { [weak self] in
                self?.output.didPressReload()
            }
        case .failFetchFriends:
            placeholderView.title = Localized.Placeholder.FailFetchGroups.title
            placeholderView.subtitle = Localized.Placeholder.FailFetchGroups.subtitle
            placeholderView.action = { [weak self] in
                self?.output.didPressReload()
            }
        }
        
        placeholderView.actionButtonTitle = Localized.Placeholder.actionButtonTitle
        
        placeholderView.isHidden = false
        tableView.isHidden = true
    }

    func hidePlaceholder() {
        placeholderView.isHidden = true
        tableView.isHidden = false
    }
    
    func showPaginationActivity() {
        footerActivityIndicator.startAnimating()
        footerActivityIndicator.frame = CGRect(
            x: 0, y: 0,
            width: tableView.bounds.width,
            height: Constants.rowHeight
        )
        tableView.tableFooterView = footerActivityIndicator
        tableView.tableFooterView?.isHidden = false
    }
    
    func showPaginationError() {
        errorFooterView.frame = CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.width,
            height: Constants.rowHeight
        )
        tableView.tableFooterView = errorFooterView
        tableView.tableFooterView?.isHidden = false
    }
    
    func hidePagination(forced: Bool) {
        footerActivityIndicator.stopAnimating()
        tableView.tableFooterView?.isHidden = true
        if forced {
            UIView.animate(withDuration: Constants.paginationEndAnimationDuration) {
                self.tableView.tableFooterView = UIView()
            }
        }
    }
    
    func showActivity() {
        tableView.isHidden = true
        headerView.isHidden = true
        placeholderView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        tableView.isHidden = false
        headerView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func showActivityOverCurrentContext() {
        showSpinner(onView: view)
    }
    
    func hideActivityOverCurrentContext() {
        removeSpinner(fromView: view)
    }
}

// MARK: - AddFriendTransitionHandler

extension AddFriendViewController: AddFriendTransitionHandler { }

// MARK: - UITableViewDataSource

extension AddFriendViewController: UITableViewDataSource {
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
        ) as? GroupCell else {
            assertionFailure("GroupCell should be at \(indexPath)")
            return .init()
        }
        
        cell.title = viewModel.title
        cell.subtitle = viewModel.subtitle

        cell.logoImageView.load(
            avatarUrl: viewModel.avatarUrl,
            placeholder: UIImage()
        ) { image, avatarUrl in
            if viewModel.avatarUrl == avatarUrl {
                cell.logoImageView.image = image
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AddFriendViewController: UITableViewDelegate {
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

        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            output.didScrollToBottom()
        }
    }

    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return cellHeights[indexPath] ?? Constants.rowHeight
    }
}

// MARK: - UIScrollViewDelegate

extension AddFriendViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let updateFactor = (scrollView.frame.height
            + scrollView.contentOffset.y
            - 84)
            * Constants.paginationUpdateFactor
        
        if updateFactor > scrollView.contentSize.height {
            output.didScrollToBottom()
        }
    }
}

// MARK: - Localization

private extension AddFriendViewController {
    enum Localized {
        // swiftlint:disable line_length
        enum PaginationError {
            static let text = NSLocalizedString(
                "GroupsViewController.PaginationError.Text",
                value: "Не загрузилось, попробуйте ещё",
                comment: "Текст в нижней часте таблицы во время ошибки"
            )
        }
        
        enum Placeholder {
            static let actionButtonTitle = NSLocalizedString(
                "GroupsViewController.Placeholder.actionButtonTitle",
                value: "Повторить",
                comment: "Title кнопки на плейсхолдере"
            )
            enum EmptyState {
                static let title = NSLocalizedString(
                    "GroupsViewController.Placeholder.EmptyState.Title",
                    value: "У вас пока нет друзей",
                    comment: "Title в Header на экране групп при пустом списке сообществ"
                )
                static let subtitle = NSLocalizedString(
                    "GroupsViewController.Placeholder.EmptyState.Subtitle",
                    value: "Найдите друзей через поиск и добавьте в друзья",
                    comment: "Subtitle в Header на экране групп при пустом списке сообществ"
                )
            }
            enum FailFetchGroups {
                static let title = NSLocalizedString(
                    "GroupsViewController.Placeholder.FailGroupsFetch.Title",
                    value: "Ошибка при получения друзей",
                    comment: "Title в Header на экране групп при ошибки получения данных"
                )
                static let subtitle = NSLocalizedString(
                    "GroupsViewController.Placeholder.FailGroupsFetch.Subtitle",
                    value: "Попробуй повторить запрос",
                    comment: "Subtitle в Header на экране групп при ошибки получения данных"
                )
            }
        }
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddFriendViewController {
    enum Constants {
        static let rowHeight: CGFloat = 60
        static let paginationEndAnimationDuration: TimeInterval = 0.3
        static let paginationUpdateFactor: CGFloat = 0.98
    }
}
