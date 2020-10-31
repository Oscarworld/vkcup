final class FriendsServiceImpl {
    private var friendsRequest: VKRequest?
    
}

// MARK: - FriendsService

extension FriendsServiceImpl: FriendsService {
    func cancelAllOperations() {
        friendsRequest?.cancel()
    }
    
    func getFriends(
        offset: Int,
        count: Int,
        completion: @escaping (Result<(friends: [Friend], count: Int), ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "offset": offset,
            "count": count,
            "order": "hints",
            "fields": "online,last_seen,photo_50,photo_100,photo_200",
        ]

        guard let request = VKApiFriends().get(parameters) else {
            completion(.failure(.failInitRequest))
            return
        }
        friendsRequest = request
        request.execute(resultBlock: { object in
            let decoder = JSONDecoder()
            guard let responseString = object?.responseString else {
                completion(.failure(.failParse))
                return
            }

            let data = Data(responseString.utf8)
            do {
                let response = try decoder.decode(Response<FriendArray>.self, from: data)
                let items = response.response.items
                completion(.success((friends: items, count: response.response.count)))
            } catch {
                completion(.failure(.failParse))
            }
        }) { error in
            completion(.failure(.fail))
        }
    }
}
