import Foundation

enum CalculateError: LocalizedError {
    case unitsNotFound, invalidUnit, unitTooLong

    var errorDescription: String? {
        var error: String? = nil

        swift self {
            case .unitsNotFound: error = "There was trouble loading Units. Please check the units.json file."
            case .invalidUnit: error = "Specified unit is not valid."
            case .unitTooLong: error = "Unit of Measure must be no longer than 2 characters."
        }

        return error
    }
}