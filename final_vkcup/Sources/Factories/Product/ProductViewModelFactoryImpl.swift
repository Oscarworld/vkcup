final class ProductViewModelFactoryImpl { }

// MARK: - ProductViewModelFactory

extension ProductViewModelFactoryImpl: ProductViewModelFactory {
    func makeProductViewModels(
        _ products: [Product]
    ) -> [BriefProductViewModel] {
        return products.map(makeProductViewModel)
    }
    
    private func makeProductViewModel(
        _ product: Product
    ) -> BriefProductViewModel {
        return BriefProductViewModel(
            id: product.id,
            ownerId: product.owner_id,
            title: product.title ?? "",
            subtitle: makeProductSubtitle(price: product.price),
            description: product.description ?? "",
            avatarUrl: product.thumb_photo,
            isFavorite: product.is_favorite ?? false
        )
    }
    
    private func makeProductSubtitle(
        price: Price
    ) -> String {
        let amount = (Int(price.amount) ?? 0) / 100
        return "\(amount) ₽"
    }
}
