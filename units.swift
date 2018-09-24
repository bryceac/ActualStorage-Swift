struct Units: Codable {
    let units: [String]

    private enum CodingKeys: String, CodingKey {
        case units
    }
}