import UIKit

final class StepsViewController: UIViewController {

    // MARK: - VIPER

    var output: StepsViewOutput!

    // MARK: - Data
    
    private let cellReuseIdentifier = "tableCell"
    private let headerReuseIdentifier = "tableHeader"

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
    
    private lazy var activityIndecator: UIActivityIndicatorView = {
        $0.color = UIColor.Styles.primary
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = UIColor.Styles.white
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(
            StepCell.self,
            forCellReuseIdentifier: cellReuseIdentifier
        )
        view.register(
            StepSection.self,
            forHeaderFooterViewReuseIdentifier: headerReuseIdentifier
        )
        view.estimatedRowHeight = Constants.estimatedRowHeight
        view.tableFooterView = UIView()
        return view
    }()

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

    private func setup() {
        navigationItem.title = "Задания"
    }

    private func setupView() {
        [
            tableView,
            activityIndecator,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndecator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndecator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Action
}

// MARK: - StepsViewInput

extension StepsViewController: StepsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showActivity() {
        tableView.isHidden = true
        activityIndecator.startAnimating()
    }
    
    func hideActivity() {
        tableView.isHidden = false
        activityIndecator.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension StepsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.numberOfItems(at: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let sectionViewModel = output.getSectionViewModel(at: section),
              let stepSection = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as? StepSection else {
            return nil
        }
        
        stepSection.titleLabel.text = sectionViewModel.title
        stepSection.checkmarkImageView.image = sectionViewModel.image
        
        return stepSection
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let itemViewModel = output.getItemViewModel(at: indexPath),
              let stepCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? StepCell else {
            return .init()
        }
        
        stepCell.titleLabel.text = itemViewModel.title
        stepCell.descriptionLabel.text = itemViewModel.description
        stepCell.locationLabel.text = itemViewModel.location
        
        if let url = URL(string: itemViewModel.photoUrl) {
            if let image = ImageCache.shared()[url] {
                stepCell.photoImageView.image = image
            } else {
                stepCell.photoImageView.load(
                    avatarUrl: itemViewModel.photoUrl,
                    placeholder: UIImage()
                ) { image, _ in
                    ImageCache.shared()[url] = image
                    stepCell.photoImageView.image = image
                }
            }
        }
        
        let attributedString = NSAttributedString(
            string: itemViewModel.buttonTitle,
            attributes: [
                .font: UIFont.Styles.title2,
                .foregroundColor: UIColor.Styles.white
            ]
        )
        stepCell.stepButton.setAttributedTitle(attributedString, for: .normal)
        stepCell.output = { [weak self] in
            self?.output.didHandleStepButton(at: indexPath)
        }
        
        return stepCell
    }
}

// MARK: - UITableViewDelegate

extension StepsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return Constants.sectionHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return Constants.estimatedRowHeight
    }
}

// MARK: - StepsTransitionHandler

extension StepsViewController: StepsTransitionHandler { }

// MARK: - Localization

private extension StepsViewController {
    enum Localized {
        // swiftlint:disable line_length
        // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension StepsViewController {
    enum Constants {
        static let sectionHeight: CGFloat = 50
        static let estimatedRowHeight: CGFloat = 400
    }
}
