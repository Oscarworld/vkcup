struct MarketInputData {
    let groupId: Int
    let groupTitle: String
}

protocol MarketModuleOutpudData: class {
    func didSelectProduct(
        _ product: BriefProductViewModel
    )
}
