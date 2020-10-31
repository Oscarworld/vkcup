import Foundation
import CoreLocation
import GoogleMapsUtils

class QuestClusterItem: NSObject, GMUClusterItem {
    let position: CLLocationCoordinate2D
    let quest: Quest

    init(quest: Quest) {
        self.quest = quest
        
        guard let latitude = quest.steps.first?.lat,
              let longitued = quest.steps.first?.lon else {
            position = .init()
            return
        }
        
        self.position = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitued
        )
    }
}
