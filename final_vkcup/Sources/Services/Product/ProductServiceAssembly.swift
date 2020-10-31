enum ProductServiceAssembly {
    static func makeProductService() -> ProductService {
        return ProductServiceImpl()
    }
}
