final class AddQuestStepPresenter {

    // MARK: - VIPER

    var interactor: AddQuestStepInteractorInput!
    var router: AddQuestStepRouterInput!

	weak var view: AddQuestStepViewInput?
    weak var moduleOutput: AddQuestStepModuleOutput?
    weak var selectTypeModuleInput: SelectActionSheetInput?

    // MARK: - Init data

    init() { }
    
    // MARK: - Stored properties
    
    private var questTypeSelectViewModel: SelectViewModel?
}

// MARK: - AddQuestStepViewOutput

extension AddQuestStepPresenter: AddQuestStepViewOutput {
	func setupView() { }
    
    func didHandleType() {
        let selectTypeViewModels = makeQuestTypesViewModel()
        let inputData = SelectActionSheetInputData(
            title: "Тип задания",
            viewModels: selectTypeViewModels,
            selected: questTypeSelectViewModel
        )
        self.selectTypeModuleInput = router.openSelectType(
            inputData: inputData,
            moduleOutput: self
        )
    }
    
    func didHandleLocation() {
        router.openSelectLocation(
            moduleOutput: self
        )
    }
    
    func didHandleAddImage() {
        router.openImagePicker(delegate: self)
    }
    
    func didHandleCreateStep(
        image: UIImage?,
        title: String?,
        description: String?
    ) {
        let typeImage: UIImage?
        switch questTypeSelectViewModel?.id {
        case 0:
            typeImage = UIImage.Styles.locationType
        case 1:
            typeImage = UIImage.Styles.qrCodeType
        case 2:
            typeImage = UIImage.Styles.questionType
        default:
            typeImage = nil
        }
        moduleOutput?.didCreateStep(
            image: image,
            typeImage: typeImage,
            title: title,
            description: description
        )
    }
    
    private func makeQuestTypesViewModel() -> [SelectViewModel] {
        return [
            SelectViewModel(
                id: 0,
                title: "Локация"
            ),
            SelectViewModel(
                id: 1,
                title: "QR-код"
            ),
            SelectViewModel(
                id: 2,
                title: "Вопрос"
            ),
        ]
    }
}

// MARK: - AddQuestStepInteractorOutput

extension AddQuestStepPresenter: AddQuestStepInteractorOutput { }

// MARK: - ImagePickerDelegate

extension AddQuestStepPresenter: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        view?.setupImage(image)
    }
}

// MARK: - SelectActionSheetOutput

extension AddQuestStepPresenter: SelectActionSheetOutput {
    func didSelect(
        _ item: SelectViewModel,
        in moduleInput: SelectActionSheetInput
    ) {
        switch moduleInput {
        case _ where moduleInput === selectTypeModuleInput:
            questTypeSelectViewModel = item
            view?.setupQuestType(item: item)
        default:
            break
        }
    }
}

// MARK: - AddQuestStepLocationModuleOutput

extension AddQuestStepPresenter: AddQuestStepLocationModuleOutput {
    func didSelectLocation(address: String, lat: Double, lon: Double) {
        router.closeSelectLocation()
        view?.setupLocation(address: address)
    }
}

// MARK: - Localized

private extension AddQuestStepPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension AddQuestStepPresenter {
    enum Constants { }
}
