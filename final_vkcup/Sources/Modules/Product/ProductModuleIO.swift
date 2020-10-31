struct ProductInputData {
    let viewModel: BriefProductViewModel
    let ownerId: Int
    let indexPath: IndexPath
}

protocol ProductOutputData: class {
    func didHandleProduct(
        at indexPath: IndexPath
    )
}
