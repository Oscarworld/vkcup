import UIKit

final class MarketViewController: UIViewController {

    // MARK: - VIPER

    var output: MarketViewOutput!

    // MARK: - Data
    
    private let cellReuseIdentifier = "collectionCell"
    private var cachedHeightsInLine: [CGFloat] = []

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
    
    private lazy var titleLabel: UILabel = {
        $0.textColor = UIColor.Styles.black
        $0.font = UIFont.Styles.title2
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var closeButton: UIButton = {
        $0.setImage(UIImage.Styles.back, for: .normal)
        $0.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        view.refreshControl = refreshControl
        view.backgroundColor = UIColor.Styles.white
        view.allowsMultipleSelection = true
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(
            ProductCell.self,
            forCellWithReuseIdentifier: cellReuseIdentifier
        )
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
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
            headerView,
            collectionView,
            activityIndicator,
            placeholderView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            closeButton,
            titleLabel,
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
            
            titleLabel.topAnchor.constraint(equalTo: viewTopAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 36),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -36),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 4),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            placeholderView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
    
    @objc
    private func didPressBackButton() {
        output.didPressBackButton()
    }
    
    @objc
    private func refreshControlValueChanged(
        _ sender: UIRefreshControl
    ) {
        if sender.isRefreshing {
            output.refreshDidPull()
        }
    }
}

// MARK: - MarketViewInput

extension MarketViewController: MarketViewInput {
    func setupTitle(groupTitle: String) {
        titleLabel.text = "Товары сообщества \(groupTitle)"
    }
    
    func reloadData() {
        cachedHeightsInLine = []
        collectionView.reloadData()
    }
    
    func appendViewModels(
        _ indexPaths: [IndexPath]
    ) {
        collectionView.insertItems(at: indexPaths)
    }
    
    func endRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func showPlaceholder(
        _ state: ProductsPlaceholderState
    ) {
        switch state {
        case .emptyList:
            placeholderView.title = Localized.Placeholder.EmptyState.title
            placeholderView.subtitle = Localized.Placeholder.EmptyState.subtitle
        case .failFetchProducts:
            placeholderView.title = Localized.Placeholder.FailFetchProducts.title
            placeholderView.subtitle = Localized.Placeholder.FailFetchProducts.subtitle
        }
        
        placeholderView.actionButtonTitle = Localized.Placeholder.actionButtonTitle
        placeholderView.action = { [weak self] in
            self?.output.didPressReload()
        }
        
        placeholderView.isHidden = false
        collectionView.isHidden = true
    }

    func hidePlaceholder() {
        placeholderView.isHidden = true
        collectionView.isHidden = false
    }
    
    func showActivityOverCurrentContext() {
        self.showSpinner(onView: view)
    }
    
    func hideActivityOverCurrentContext() {
        self.removeSpinner(fromView: view)
    }
    
    func showActivity() {
        collectionView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

// MARK: - UICollectionViewDelegate

extension MarketViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        output.didSelectItem(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension MarketViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return output.numberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let viewModel = output.getViewModel(in: indexPath),
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellReuseIdentifier,
            for: indexPath
        ) as? ProductCell else {
            assertionFailure("CommunityCell should be at \(indexPath)")
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let lastSectionIndex = collectionView.numberOfSections - 1
        let lastRowIndex = collectionView.numberOfItems(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            output.didScrollToBottom()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MarketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsWidth = collectionView.frame.width
            - Constants.insetForSection.left
            - Constants.insetForSection.right
            - Constants.minimumInteritemSpacingForSection * CGFloat(Constants.numberRowInLine - 1)
        let width = itemsWidth / CGFloat(Constants.numberRowInLine)
        let lineNumber = indexPath.row / Constants.numberRowInLine
        
        let height: CGFloat
        if lineNumber < cachedHeightsInLine.count {
            height = cachedHeightsInLine[lineNumber]
        } else {
            let viewModelsOnLine = output.getViewModels(
                in: indexPath.row / Constants.numberRowInLine,
                numberRowInLine: Constants.numberRowInLine
            )
            
            let heightOfViewModelsOnLine = viewModelsOnLine.map {
                ProductCell.calculateHeight(
                    width: width,
                    title: $0.title,
                    subtitle: $0.subtitle
                )
            }
            height = heightOfViewModelsOnLine.max() ?? 0
        }
        
        return .init(
            width: width,
            height: height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return Constants.insetForSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.minimumLineSpacingForSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.minimumInteritemSpacingForSection
    }
}

// MARK: - MarketTransitionHandler

extension MarketViewController: MarketTransitionHandler { }

// MARK: - Localization

private extension MarketViewController {
    enum Localized {
        // swiftlint:disable line_length
        enum Placeholder {
             static let actionButtonTitle = NSLocalizedString(
                 "MarketViewController.Placeholder.actionButtonTitle",
                 value: " Повторить",
                 comment: "Title кнопки на плейсхолдере"
             )
             enum EmptyState {
                 static let title = NSLocalizedString(
                     "MarketViewController.Placeholder.EmptyState.Title",
                     value: "Список товаров пуст",
                     comment: "Title в Header на экране продуктов при пустом списке сообществ"
                 )
                 static let subtitle = NSLocalizedString(
                     "MarketViewController.Placeholder.EmptyState.Subtitle",
                     value: "У сообщества пока нет ниодного товара",
                     comment: "Subtitle в Header на экране продуктов при пустом списке продуктов"
                 )
             }
             enum FailFetchProducts {
                 static let title = NSLocalizedString(
                     "MarketViewController.Placeholder.FailFetchProducts.Title",
                     value: "Ошибка при получения товаров",
                     comment: "Title в Header на экране продуктов при ошибки получения продуктов"
                 )
                 static let subtitle = NSLocalizedString(
                     "MarketViewController.Placeholder.FailFetchProducts.Subtitle",
                     value: "Попробуй повторить запрос",
                     comment: "Subtitle в Header на экране продуктов при ошибки получения продуктов"
                 )
             }
         }
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension MarketViewController {
    enum Constants {
        static let paginationUpdateFactor: CGFloat = 0.98
        static let numberRowInLine = 2
        static let insetForSection = UIEdgeInsets(top: 8, left: 12, bottom: 0, right: 12)
        static let minimumLineSpacingForSection: CGFloat = 12
        static let minimumInteritemSpacingForSection: CGFloat = 4
    }
}
