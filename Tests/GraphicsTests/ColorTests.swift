import XCTest
@testable import Graphics

final class ColorTests: XCTestCase {
	func testColor() throws {
		let yellowRGB = Color(rgb: 0xFFFF00)
		XCTAssertEqual(yellowRGB.red, 0xFF)
		XCTAssertEqual(yellowRGB.green, 0xFF)
		XCTAssertEqual(yellowRGB.blue, 0)
		XCTAssertEqual(yellowRGB.alpha, 0xFF)
		XCTAssertEqual(yellowRGB.rgb, 0xFFFF00)

		let transparentCyanRGBA = Color(rgba: 0x00FFFFCC)
		XCTAssertEqual(transparentCyanRGBA.red, 0)
		XCTAssertEqual(transparentCyanRGBA.green, 0xFF)
		XCTAssertEqual(transparentCyanRGBA.blue, 0xFF)
		XCTAssertEqual(transparentCyanRGBA.alpha, 0xCC)
		XCTAssertEqual(transparentCyanRGBA.rgba, 0x00FFFFCC)
		XCTAssertEqual(transparentCyanRGBA.argb, 0xCC00FFFF)
		XCTAssertEqual(transparentCyanRGBA.rgb, 0x00FFFF)

		let magentaARGB = Color(argb: 0xAAFF00FF)
		XCTAssertEqual(magentaARGB.red, 0xFF)
		XCTAssertEqual(magentaARGB.green, 0x00)
		XCTAssertEqual(magentaARGB.blue, 0xFF)
		XCTAssertEqual(magentaARGB.alpha, 0xAA)
		XCTAssertEqual(magentaARGB.argb, 0xAAFF00FF)
	}
}
