protocol ProductViewModelFactory {
    func makeProductViewModels(_ products: [Product]) -> [BriefProductViewModel]
}
