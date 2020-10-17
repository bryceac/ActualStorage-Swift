import ArgumentParser
import Foundation

struct Actual: ParsableCommand {
    @Argument var size: Int
    @Argument var unit: String

    var units: [String]? {
        let JSON_DECODER = JSONDecoder()

        guard let UNIT_URL = Bundle.module.url(forResource: "units", withExtension: "json"), let UNIT_DATA = try? Data(contentsOf: UNIT_URL), let UNITS = try? JSON_DECODER.decode([String].self, from: UNIT_DATA) else { return nil }

        return UNITS
    }

    func run() {
        
    }

    func calculate() throws -> Double {
        guard let units = units else {
            throw CalculateError.unitsNotFound
        }

        guard case 1...2 = unit.count else {
            
        }

        guard let INDEX = units.firstIndex(where: { unit})
    }
}