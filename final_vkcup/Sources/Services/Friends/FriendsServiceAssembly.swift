enum FriendsServiceAssembly {
    static func makeFriendsService() -> FriendsService {
        return FriendsServiceImpl()
    }
}
