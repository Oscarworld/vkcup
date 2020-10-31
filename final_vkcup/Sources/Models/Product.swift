struct ProductArray: Codable {
    let count: Int
    let items: [Product]
}

struct Product: Codable {
    let id: Int
    let owner_id: Int
    let title: String?
    let description: String?
    let thumb_photo: String?
    let is_favorite: Bool?
    let price: Price
}

struct Price: Codable {
    let amount: String
    let currency: Currency
    let text: String?
}

struct Currency: Codable {
    let id: Int
    let name: String
}
