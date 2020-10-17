import ArgumentParser
import Foundation

struct Actual: ParsableCommand {
    @Argument var size: Int
    @Argument var unit: String

    func run() {
        
    }
}