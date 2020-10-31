protocol FriendsService {
    func cancelAllOperations()
    
    func getFriends(
        offset: Int,
        count: Int,
        completion: @escaping (Result<(friends: [Friend], count: Int), ServiceError>) -> Void
    )
}
