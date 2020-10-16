import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ActualStorage_SwiftTests.allTests),
    ]
}
#endif
