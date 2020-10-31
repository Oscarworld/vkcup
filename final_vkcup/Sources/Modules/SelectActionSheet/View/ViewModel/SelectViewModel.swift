struct SelectViewModel {
    let id: Int
    let title: String
}

// MARK: - Equatable

extension SelectViewModel: Equatable {
    public static func == (lhs: SelectViewModel, rhs: SelectViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
    }
}
