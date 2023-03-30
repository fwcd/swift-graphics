import XCTest

@testable import PlatformGraphics

final class ContextTests: XCTestCase {
    func testSimpleDrawRect() throws {
        let ctx = try PlatformGraphicsContext(width: 8, height: 8, format: .g8)
        ctx.draw(rect: Rectangle(fromX: 0, y: 4, width: 8, height: 4, color: .white, isFilled: true))
        try ctx.withUnsafeMutableBytes { buffer in
            // first half should be black, second half should be white
            for idx in 0..<32 {
                XCTAssertEqual(buffer[idx], 0, "Expected black pixel")
            }
            for idx in 32..<64 {
                XCTAssertEqual(buffer[idx], 255, "Expected white pixel")
            }
        }
    }
}
