final class AddFriendInteractor {

    // MARK: - VIPER

    weak var output: AddFriendInteractorOutput?

    // MARK: - Data
    
    private let friendsService: FriendsService

    // MARK: - Init

	init(
        friendsService: FriendsService
    ) {
        self.friendsService = friendsService
    }
}

// MARK: - AddFriendInteractorInput

extension AddFriendInteractor: AddFriendInteractorInput {
    func cancelAllOperations() {
        friendsService.cancelAllOperations()
    }
    
    func getFriends(
        count: Int,
        offset: Int,
        context: AddFriendInteractorUpdatingContext
    ) {
        friendsService.getFriends(
            offset: offset,
            count: count
        ) { [weak self] result in
            guard let output = self?.output else { return }
            
            switch result {
            case .success(let result):
                output.didFetchFriends(
                    count: result.count,
                    friends: result.friends,
                    context: context
                )
            case .failure(let error):
                output.didFailFetchFriends(
                    error,
                    context: context
                )
            }
        }
    }
}
