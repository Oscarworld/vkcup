struct BriefGroupViewModel {
    let id: Int
    let title: String
    let subtitle: String
    let avatarUrl: String?
}

// MARK: - Equatable

extension BriefGroupViewModel: Equatable {
    public static func == (lhs: BriefGroupViewModel, rhs: BriefGroupViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.avatarUrl == rhs.avatarUrl
    }
}
