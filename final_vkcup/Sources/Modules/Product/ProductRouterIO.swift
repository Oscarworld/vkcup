/// Product router input
protocol ProductRouterInput: class {
    func close()
    
    func showAlert(
        title: String?,
        message: String?
    )
}
