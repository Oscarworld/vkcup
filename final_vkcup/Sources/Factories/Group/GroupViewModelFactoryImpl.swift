final class GroupViewModelFactoryImpl { }

// MARK: - GroupsViewModelFactory

extension GroupViewModelFactoryImpl: GroupViewModelFactory {
    func makeGroupViewModels(
        _ groups: [VKGroup]
    ) -> [BriefGroupViewModel] {
        return groups.map(makeGroupViewModel)
    }
    
    private func makeGroupViewModel(
        _ group: VKGroup
    ) -> BriefGroupViewModel {
        return BriefGroupViewModel(
            id: group.id.intValue,
            title: group.name ?? "",
            subtitle: group.is_closed.intValue == 1
                ? "Закрытая группа"
                : "Открытая группа",
            avatarUrl: group.photo_50
                ?? group.photo_100
                ?? group.photo_200
        )
    }
}
