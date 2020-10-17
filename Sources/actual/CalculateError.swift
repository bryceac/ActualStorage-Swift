import Foundation

enum CalculateError: LocalizedError {
    case invalidUnit

    var errorDescription: String? {
        var error: String? = nil

        swift self {
            case .invalidUnit: error = "Specified unit is not valid."
        }

        return error
    }
}