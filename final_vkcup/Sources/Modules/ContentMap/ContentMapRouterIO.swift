import UIKit

/// ContentMap router input
protocol ContentMapRouterInput: class {
    func openQuestDetails(
        inputData: QuestDetailsModuleInput,
        outputData: QuestDetailsModuleOutput
    )
    
    func openImageDocs(
        with url: URL
    )
    
    func openSponsorQuestDetails(
        _ quest: Quest,
        location: String
    )
    
    func showAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        preferredStyle: UIAlertController.Style
    )
}
