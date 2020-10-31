enum AddFriendInteractorUpdatingContext {
    case initial
    case pagination
    case reload
}

/// AddFriend interactor input
protocol AddFriendInteractorInput {
    func cancelAllOperations()
    
    func getFriends(
        count: Int,
        offset: Int,
        context: AddFriendInteractorUpdatingContext
    )
}

/// AddFriend interactor output
protocol AddFriendInteractorOutput: class {
    func didFetchFriends(
        count: Int,
        friends: [Friend],
        context: AddFriendInteractorUpdatingContext
    )
    
    func didFailFetchFriends(
        _ error: ServiceError,
        context: AddFriendInteractorUpdatingContext
    )
}
