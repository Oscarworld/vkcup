final class ContentMapPresenter {

    // MARK: - VIPER

    var interactor: ContentMapInteractorInput!
    var router: ContentMapRouterInput!

	weak var view: ContentMapViewInput?
    
    // MARK: - Data
    

    // MARK: - Init data

    init() {}
    
    // MARK: - Stored data
    
    private var timer: Timer?
    private var quests: [Quest] = []
    private var questRequestType: QuestRequestType = .all
}

// MARK: - ContentMapViewOutput

extension ContentMapPresenter: ContentMapViewOutput {
	func setupView() {
        view?.setupClusterManager()
    }
    
    func changeQuestRequestType(
        _ type: QuestRequestType,
        lat: Double,
        lon: Double
    ) {
        questRequestType = type
        moveCamera(
            lat: lat,
            lon: lon
        )
    }
    
    func moveCamera(
        lat: Double,
        lon: Double
    ) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.3,
            repeats: false,
            block: { [weak self] _ in
                DispatchQueue.global().async { [weak self] in
                    guard let self = self else { return }
                    
                    self.interactor.cancelAllOperations()
                    self.interactor.getQuests(
                        requestType: self.questRequestType,
                        lat: lat,
                        lon: lon
                    )
                }
        })
    }

    func didHandleQuest(
        _ quest: Quest
    ) {
        let inputData = QuestDetailsModuleInput(quest: quest)
        router.openQuestDetails(
            inputData: inputData,
            outputData: self
        )
    }
}

// MARK: - ContentMapInteractorOutput

extension ContentMapPresenter: ContentMapInteractorOutput {
    func didFetchQuests(
        _ quests: [Quest]
    ) {
        self.quests = quests
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let view = self.view else { return }
            
            view.setupQuests(quests)
        }
    }
    
    func didFailFetchQuests(
        _ error: ServiceError
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.showError(error)
        }
    }
    
    private func showError(
        _ error: ServiceError
    ) {
        let title: String
        let message: String
        switch error {
        case ServiceError.failInitRequest:
            title = Localized.Error.FailInitRequest.title
            message = Localized.Error.FailInitRequest.message
        case ServiceError.failParse:
            title = Localized.Error.FailParse.title
            message = Localized.Error.FailParse.message
        case ServiceError.fail:
            return
        }
        
        let actions = [
            UIAlertAction.okAction
        ]
        router.showAlert(
            title: title,
            message: message,
            actions: actions,
            preferredStyle: .alert
        )
    }
}

// MARK: - QuestDetailsModuleOutput

extension ContentMapPresenter: QuestDetailsModuleOutput {
    func didHandleOpenQuest(
        _ quest: Quest,
        location: String
    ) {
        router.openSponsorQuestDetails(
            quest,
            location: location
        )
    }
}
// MARK: - Localized

private extension ContentMapPresenter {
    enum Localized {
    // swiftlint:disable line_length
        enum Error {
            enum Common {
                static let title = NSLocalizedString(
                    "ContentMapPresenter.Error.Common.Title",
                    value: "Ошибка",
                    comment: "Title общей ошибки на карте"
                )
                static let message = NSLocalizedString(
                    "ContentMapPresenter.Error.Common.Message",
                    value: "Что-то пошло не так",
                    comment: "Message общей ошибки на карте"
                )
            }
            enum FailInitRequest {
                static let title = NSLocalizedString(
                    "ContentMapPresenter.Error.FailInitRequest.Title",
                    value: "Ошибка запроса",
                    comment: "Title ошибки создания запроса на карте"
                )
                static let message = NSLocalizedString(
                    "ContentMapPresenter.Error.FailInitRequest.Message",
                    value: "Некорректный запрос",
                    comment: "Message ошибки создания запроса на карте"
                )
            }
            enum FailParse {
                static let title = NSLocalizedString(
                    "ContentMapPresenter.Error.FailParse.Title",
                    value: "Ошибка данных",
                    comment: "Title ошибки парсинга данных на карте"
                )
                static let message = NSLocalizedString(
                    "ContentMapPresenter.Error.FailParse.Message",
                    value: "Невозможно обработать данные",
                    comment: "Message ошибки парсинга данных на карте"
                )
            }
        }
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension ContentMapPresenter {
    enum Constants { }
}
