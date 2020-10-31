struct Response<T: Codable>: Codable {
    let response: T
}

struct CityArray: Codable {
    let count: Int
    let items: [City]
}

struct City: Codable {
    let id: Int
    let title: String
}
