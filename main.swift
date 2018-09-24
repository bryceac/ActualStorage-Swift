import Foundation // import base class so that everything works

let file = Bundle.main.path(forResource: "units", ofType: "json") // retrieve json file for loading
var units: Units!, size: Int = 0, unit: Int = 0 // create variables to hold storage object and data to use for calculation

// function to get integer string
func numbersInString(_ string: String) -> String {
    var number = ""
    for char in string {
        if Int(String(char)) != nil {
            number += String(char)
        }
    }
    return number
}

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

// make conditional that allows commandline arguments and does things based on the arguments, or gives prompts, if none exist
if (CommandLine.argc < 2) {
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
} else {
    if (CommandLine.argc == 3) { // code to run if arguments have spaces
        for argument in CommandLine.arguments {
            let idx = CommandLine.arguments.index(where: { $0.caseInsensitiveCompare(argument) == .orderedSame }) // get index of argument, to make sure it is not first argument

            if (numbersInString(argument).count > 0 && idx != 0) {
                size = Int(numbersInString(argument)) ?? 0
            } else if (idx != 0) {
                // loop through array to match it to proper unit of measure
                for measure in units.units {
                    if (argument.caseInsensitiveCompare(measure) == .orderedSame || argument.caseInsensitiveCompare(measure.prefix(1)) == .orderedSame) {
                        unit = units.units.index(of: measure) ?? 0
                        unit += 1
                    }
                }
            }
        }
    } else if (CommandLine.argc > 3) { // make sure there are no more than 3 arguments
        print("Too many arguments passed.")
    } else { // code to run if there are no spaces in argument
        if (numbersInString(CommandLine.arguments[1]).count > 0) {
            size = Int(numbersInString(CommandLine.arguments[1])) ?? 0

            // loop through unit array and match it with the proper unit of measure
            for measure in units.units {
                if (CommandLine.arguments[1].suffix(2).caseInsensitiveCompare(measure) == .orderedSame || CommandLine.arguments[1].suffix(1).caseInsensitiveCompare(measure.prefix(1)) == .orderedSame) {
                    unit = units.units.index(of: measure) ?? 0
                    unit += 1
                }
            }
        } else {
            print("Storage capacity is missing.")
        }
    }
}

if (size != 0 && unit != 0) {
    let actual = String(format: "%.2f", actualStorage(size: size, inUnit: units.units[unit-1], withUnits: units.units)) // get results and round to two places

    print("You have approximately \(actual) \(units.units[unit-1]) of usable storage.") // display the usable storage
}
