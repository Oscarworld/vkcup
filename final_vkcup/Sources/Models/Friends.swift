struct FriendArray: Codable {
    let count: Int
    let items: [Friend]
}

struct LastSeen: Codable {
    let time: Int?
    let platform: Int?
}

struct Friend: Codable {
    let id: Int
    let first_name: String?
    let last_name: String?
    let last_seen: LastSeen?
    let online: Int?
    let photo_50: String?
    let photo_100: String?
    let photo_200: String?
}
