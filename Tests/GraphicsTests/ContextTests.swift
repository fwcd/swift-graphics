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

    func testMemoryIsInitialized() throws {
        // This test is a bit statistical, which I don't like, but I'm not sure how better
        // to implement this. There was a bug whereby the data for CoreGraphics was not
        // being initialized, which usually was fine the first time you created a context
        // but at some point would start to contain old data as the memory allocator re-used
        // previously released memory. Because we can't force the bug, this test just repeats
        // it enough that FOR ME we hit the issue, and so I could be convinced my fix worked,
        // but I'm open to better implementations here.
        for _ in 0..<10 {
            let ctx = try PlatformGraphicsContext(width: 100, height: 100, format: .g8)
            try ctx.withUnsafeMutableBytes { buffer in
                // a new buffer should be all black
                for idx in 0..<10000 {
                    XCTAssertEqual(buffer[idx], 0, "Expected black pixel")
                }
            }
            // fill with white - eventually we'll be re-allocated this memory
            ctx.draw(rect: Rectangle(fromX: 0, y: 0, width: 100, height: 100, color: .white, isFilled: true))
        }
    }
}
