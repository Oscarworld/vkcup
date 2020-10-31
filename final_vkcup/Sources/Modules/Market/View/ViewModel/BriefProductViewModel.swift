struct BriefProductViewModel {
    let id: Int
    let ownerId: Int
    let title: String
    let subtitle: String
    let description: String
    let avatarUrl: String?
    var isFavorite: Bool
}

// MARK: - Equatable

extension BriefProductViewModel: Equatable {
    public static func == (lhs: BriefProductViewModel, rhs: BriefProductViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.ownerId == rhs.ownerId
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.description == rhs.description
            && lhs.avatarUrl == rhs.avatarUrl
            && lhs.isFavorite == rhs.isFavorite
    }
}
