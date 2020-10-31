import GoogleMapsUtils

final class QuestMarker: GMSMarker {
    let quest: Quest

    init(quest: Quest) {
        self.quest = quest
        super.init()
        
        if case let .sponsor(questType) = quest.type,
           questType == .onlyForMembers {
            self.icon = UIImage.Styles.privateQuest
            self.iconView = nil
        } else {
            let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 48, height: 48))
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 6
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.Styles.white.cgColor
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = UIColor.Styles.white
            if let thumbUrl = quest.steps.first?.photo,
               let url = URL(string: thumbUrl) {
                if let image = ImageCache.shared()[url] {
                    imageView.image = image
                } else {
                    imageView.load(
                        avatarUrl: thumbUrl,
                        placeholder: UIImage()
                    ) { image, _ in
                        ImageCache.shared()[url] = image
                        imageView.image = image
                    }
                }
            }
            self.icon = nil
            self.iconView = imageView
        }
        
        self.zIndex = Int32(quest.id) ?? 0
    }
}
