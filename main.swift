import Foundation // import base class so that everything works

let file = Bundle.main.path(forResource: "units", ofType: "json") // retrieve json file for loading
var units: Units!, size: Int = 0, unit: Int = 0 // create variables to hold storage object and data to use for calculation

// check if file exists and load it
if (file != nil) {
    do {
        let decoder = JSONDecoder() // create variable for easy JSON decoding
        let content = try Data(String(contentsOfFile: file!, encoding: .utf8).utf8) // convert file content to data
        units = try decoder.decode(Units.self, from:content) // create storage Object from JSON
    } catch {
        print("could not parse JSON") // default message for when JSON could not be parsed
    }
} else {
    print("could not load file") // message to be thrown if file could not be found
}

// ask the user to input storage capacity
repeat {
    print("Enter device capacity: ")
    size = Int(readLine()!) ?? 0 // convert user input into Int
} while (size == 0)

// ask user to specify unit of measure
repeat {
    for unit in units.units {
        let idx = units.units.index(where: { $0 == unit})!
        print("\(idx+1). \(unit)")
    }
    print("Enter unit of measure: ")
    unit = Int(readLine()!) ?? 0
} while (unit == 0)

let actual = String(format: "%.2f", actualStorage(size: size, inUnit: units.units[unit-1], withUnits: units.units)) // get results and round to two places

print("You have approximately \(actual) \(units.units[unit-1]) of usable storage.") // display the usable storage
