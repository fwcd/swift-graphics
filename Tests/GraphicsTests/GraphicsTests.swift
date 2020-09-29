import XCTest
@testable import Graphics

final class GraphicsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Graphics().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
