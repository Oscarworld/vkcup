import UIKit

/// Groups router input
protocol GroupsRouterInput: class {
    func showAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        preferredStyle: UIAlertController.Style
    )
    
    func openCitySelector(
        inputData: SelectActionSheetInputData,
        moduleOutput: SelectActionSheetOutput?
    )
    
    func openGroup(
        inputData: MarketInputData,
        outputData: MarketModuleOutpudData
    )
    
    func closeGroup()
}
