final class CreateQuestPresenter {

    // MARK: - VIPER

    var interactor: CreateQuestInteractorInput!
    var router: CreateQuestRouterInput!

	weak var view: CreateQuestViewInput?
    weak var selectTypeModuleInput: SelectActionSheetInput?
    

    // MARK: - Init data

    init() { }
    
    // MARK: - Stored properties
    
    private var questTypeSelectViewModel: SelectViewModel?
}

// MARK: - CreateQuestViewOutput

extension CreateQuestPresenter: CreateQuestViewOutput {
	func setupView() { }
    
    func didHandleType() {
        let selectTypeViewModels = makeQuestTypesViewModel()
        let inputData = SelectActionSheetInputData(
            title: "Тип квеста",
            viewModels: selectTypeViewModels,
            selected: questTypeSelectViewModel
        )
        self.selectTypeModuleInput = router.openSelectType(
            inputData: inputData,
            moduleOutput: self
        )
    }
    
    func didHandleAddGift() {
        let productAction = UIAlertAction(
            title: "Товар",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            self.router.openSelectProduct(outputData: self)
        }
        
        let moneyAction = UIAlertAction(
            title: "Денежный приз",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            self.router.openAddMoney(moduleOutput: self)
        }
        
        let promocodeAction = UIAlertAction(
            title: "Промокод",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            self.router.openAddPromocode(moduleOutput: self)
        }
        
        let cancelAction = UIAlertAction(
            title: "Отменить",
            style: .cancel
        )
        
        router.showActionSheetView(
            title: nil,
            message: "Выберите тип приза",
            actions: [
                productAction,
                moneyAction,
                promocodeAction,
                cancelAction,
            ]
        )
    }
    
    func didHandleCreateButton() {
        router.showSuccessCreateQuest()
    }
    
    func didHandleAddFriend() {
        router.openAddFriends(moduleOutput: self)
    }
    
    func didHandleAddStep() {
        router.opemAddQuestStep(moduleOutput: self)
    }
    
    private func makeQuestTypesViewModel() -> [SelectViewModel] {
        return [
            SelectViewModel(
                id: 0,
                title: "Спонсорский"
            ),
            SelectViewModel(
                id: 1,
                title: "Персональный"
            ),
            SelectViewModel(
                id: 2,
                title: "Закрытый"
            ),
        ]
    }
}

// MARK: - CreateQuestInteractorOutput

extension CreateQuestPresenter: CreateQuestInteractorOutput { }

// MARK: - SelectActionSheetOutput

extension CreateQuestPresenter: SelectActionSheetOutput {
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

// MARK: - AddPromocodeModuleOutput

extension CreateQuestPresenter: AddPromocodeModuleOutput {
    func didAddPromocode(
        _ promocode: PromocodeViewModel
    ) {
        router.closeAddPromocode()
        view?.addPromocode(promocode)
    }
}

// MARK: - AddFriendModuleOutput

extension CreateQuestPresenter: AddFriendModuleOutput {
    func didAddFriend(_ friend: BriefGroupViewModel) {
        router.closeAddPromocode()
        view?.addFriend(friend)
    }
}

// MARK: - GroupsModuleOutputData

extension CreateQuestPresenter: GroupsModuleOutputData {
    func didSelectProduct(_ product: BriefProductViewModel) {
        router.closeSelectProduct()
        view?.addProduct(product)
    }
}

// MARK: - AddMoneyModuleOutput

extension CreateQuestPresenter: AddMoneyModuleOutput {
    func didSelect(_ item: SelectViewModel, value: String) {
        router.closeAddPromocode()
        view?.addMoney(item, value: value)
    }
}

// MARK: - AddQuestStepModuleOutput

extension CreateQuestPresenter: AddQuestStepModuleOutput {
    func didCreateStep(
        image: UIImage?,
        typeImage: UIImage?,
        title: String?,
        description: String?
    ) {
        router.closeAddPromocode()
        view?.addStep(
            image: image,
            typeImage: typeImage,
            title: title,
            description: description
        )
    }
}

// MARK: - Localized

private extension CreateQuestPresenter {
    enum Localized {
    // swiftlint:disable line_length
    // swiftlint:enable line_length
    }
}

// MARK: - Constants

private extension CreateQuestPresenter {
    enum Constants { }
}
