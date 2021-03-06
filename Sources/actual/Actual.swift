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
        do {
            let ACTUAL_STORAGE = try calculate()

            let ACTUAL_STORAGE_STRING = String(format: "%.2f", ACTUAL_STORAGE)

            print("Approximate Usable Storage: \(ACTUAL_STORAGE_STRING) \(unit)")
        } catch (let error) {
            print("\(error.localizedDescription)")
        }
    }

    func calculate() throws -> Double {
        guard let units = units else {
            throw CalculateError.unitsNotFound
        }

        guard case 1...2 = unit.count else {
            throw CalculateError.unitTooLong
        }

        guard let INDEX = units.firstIndex(where: { unit.count == 1 ? $0.prefix(1).localizedCaseInsensitiveCompare(unit) == .orderedSame : $0.localizedCaseInsensitiveCompare(unit) == .orderedSame }) else {
            throw CalculateError.invalidUnit
        }

        return (Double(size)*pow(Double(1_000), Double(INDEX+1)))/pow(Double(1_024), Double(INDEX+1))
    }
}