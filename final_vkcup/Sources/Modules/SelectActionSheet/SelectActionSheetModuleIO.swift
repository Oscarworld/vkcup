struct SelectActionSheetInputData {
    let title: String
    let viewModels: [SelectViewModel]
    let selected: SelectViewModel?
}

protocol SelectActionSheetInput: class {}

protocol SelectActionSheetOutput: class {
    func didSelect(
        _ item: SelectViewModel,
        in moduleInput: SelectActionSheetInput
    )
}
