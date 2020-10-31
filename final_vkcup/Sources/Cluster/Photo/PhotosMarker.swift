import GoogleMapsUtils

final class QuestsMarker: GMSMarker {
    init(
        quest: Quest,
        count: Int
    ) {
        super.init()
        let text = "\(count)"
        let width = 24 + (text.count - 1) * 6
        let counter = UILabel(frame: .init(x: 3 + 48 - width / 2, y: 0, width: width, height: 24))
        counter.text = text
        counter.font = UIFont.Styles.subtitle3
        counter.backgroundColor = UIColor.Styles.second
        counter.textAlignment = .center
        counter.textColor = UIColor.Styles.white
        counter.layer.cornerRadius = 12
        counter.layer.masksToBounds = true
        
        let imageView = UIImageView(frame: .init(x: 0, y: 9, width: 54, height: 54))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.Styles.white.cgColor
        imageView.backgroundColor = UIColor.Styles.white
        imageView.contentMode = .scaleAspectFill
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
        
        let contentView = UIView(frame: .init(x: 0, y: 0, width: 3 + 48 + width / 2, height: 63))
        contentView.addSubview(imageView)
        contentView.addSubview(counter)
        
        self.zIndex = Int32(quest.id) ?? 0
        self.iconView = contentView
    }
}
