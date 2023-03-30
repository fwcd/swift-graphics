import XCTest

import Utils

@testable import Graphics

final class ShapeTests: XCTestCase {
    static var allTests = [
        ("testStrokedPolygon", testStrokedPolygon),
        ("testFilledPolygon", testFilledPolygon),
        ("testFilledPolygonAlreadyClosed", testFilledPolygonAlreadyClosed),
    ]

    func testStrokedPolygon() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1)]
        let polygon = Polygon(points: points, isFilled: false)
        XCTAssertEqual(points, polygon.points, "Polygon should not have modified points")
    }

    func testFilledPolygon() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1)]
        let polygon = Polygon(points: points, isFilled: true)
        XCTAssertEqual(points.count + 1, polygon.points.count, "Polygon should have extra points")
        XCTAssertEqual(polygon.points.first!, polygon.points.last!, "Polygon should be closed.")
    }

    func testFilledPolygonAlreadyClosed() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1), Vec2(x: 1, y:2)]
        let polygon = Polygon(points: points, isFilled: true)
        XCTAssertEqual(points, polygon.points, "Polygon should not have extra points")
    }
}
