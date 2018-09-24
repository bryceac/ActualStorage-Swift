import Foundation // import Foundation, so that necessary math works right
    
// following function takes a size specification and does math based on where the unit of measure is in the units array, so sizes beyond Yottabyte can be easily dealt with
func actualStorage(size: Int, inUnit: String, withUnits: [String]) -> Double {
    let idx = withUnits.index(where: { $0.caseInsensitiveCompare(inUnit) == .orderedSame }) ?? 0 // get index of unit or return zero
        
    return (Double(size)*pow(Double(1000), Double(idx+1)))/pow(Double(1024), Double(idx+1)) // do calculation and return results
}
