enum GroupServiceAssembly {
    static func makeGroupService() -> GroupService {
        return GroupServiceImpl()
    }
}
