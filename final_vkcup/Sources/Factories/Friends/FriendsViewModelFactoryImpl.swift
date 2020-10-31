final class FriendsViewModelFactoryImpl {
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "d MMM в HH:mm"
        return $0
    }(DateFormatter())
}

// MARK: - FriendsViewModelFactory

extension FriendsViewModelFactoryImpl: FriendsViewModelFactory {
    func makeFriendsViewModels(
        _ friends: [Friend]
    ) -> [BriefGroupViewModel] {
        return friends.map(makeGroupViewModel)
    }
    
    private func makeGroupViewModel(
        _ friend: Friend
    ) -> BriefGroupViewModel {
        let subtitle: String
        if let online = friend.online,
           online == 1 {
            subtitle = "Онлайн"
        } else if let lastSeen = friend.last_seen?.time {
            subtitle = "В сети был(а) \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(lastSeen))))"
        } else {
            subtitle = "Оффлайн"
        }
        
        return BriefGroupViewModel(
            id: friend.id,
            title: "\(friend.first_name ?? "") \(friend.last_name ?? "")",
            subtitle: subtitle,
            avatarUrl: friend.photo_50
                ?? friend.photo_100
                ?? friend.photo_200
        )
    }
}
