// The Units struct is used to load units of measure for secondary storage from a JSON file
struct Units: Codable {
    let units: [String]

    private enum CodingKeys: String, CodingKey {
        case units
    }
}