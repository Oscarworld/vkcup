/// Market router input
protocol MarketRouterInput: class {
    func showAlert(
        title: String?,
        message: String?
    )
    
    func openProduct(
        inputData: ProductInputData,
        outputData: ProductOutputData
    )
    
    func close()
}
