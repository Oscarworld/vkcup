final class GroupServiceImpl {
    private var groupRequest: VKRequest?
    
}

// MARK: - GroupService

extension GroupServiceImpl: GroupService {
    func cancelAllOperations() {
        groupRequest?.cancel()
    }
    
    func getCities(
        completion: @escaping (Result<[City], ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "country_id": 1,
        ]
        
        guard let request = VKApi.request(
            withMethod: "database.getCities",
            andParameters: parameters
        ) else {
            completion(.failure(.failInitRequest))
            return
        }
        
        request.execute(resultBlock: { object in
            let decoder = JSONDecoder()
            guard let responseString = object?.responseString else {
                completion(.failure(.failParse))
                return
            }
            
            let data = Data(responseString.utf8)
            do {
                let response = try decoder.decode(Response<CityArray>.self, from: data)
                let items = response.response.items
                completion(.success(items))
            } catch {
                completion(.failure(.failParse))
            }
        }) { error in
            completion(.failure(.fail))
        }
    }
    
    func searchGroup(
        cityId: Int,
        offset: Int,
        count: Int,
        completion: @escaping (Result<(groups: [VKGroup], count: Int), ServiceError>) -> Void
    ) {
        let parameters: [String: Any] = [
            "q": "apple",
            "city_id": cityId,
            "offset": offset,
            "count": count,
            "market": 1,
        ]
        
        guard let request = VKApi.request(
            withMethod: "groups.search",
            andParameters: parameters
        ) else {
            completion(.failure(.failInitRequest))
            return
        }

        groupRequest = request
        request.execute(resultBlock: { object in
            guard let dictionary = object?.json as? [AnyHashable : Any],
                  let groups = VKGroups(dictionary: dictionary),
                  let items = groups.items as? [VKGroup] else {
                completion(.failure(.failParse))
                return
            }

            completion(.success((groups: items, count: Int(groups.count))))
        }) { error in
            completion(.failure(.fail))
        }
    }
}
