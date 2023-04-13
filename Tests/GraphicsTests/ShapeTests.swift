import XCTest
import Utils
@testable import Graphics

final class ShapeTests: XCTestCase {
    func testEmptyPointsList() {
        let polygon = Polygon(points: [Vec2<Double>]())
        XCTAssertEqual(polygon.paths.count, 0)
    }

    func testEmptyPathsList() {
        let polygon = Polygon(paths: [[Vec2<Double>]]())
        XCTAssertEqual(polygon.paths.count, 0)
    }

    func testStrokedPolygon() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1)]
        let polygon = Polygon(points: points, isFilled: false)

        XCTAssertEqual(polygon.paths.count, 1, "Should be one path in polygon")
        let path = polygon.paths.first!

        XCTAssertEqual(points.count + 1, path.count, "Polygon should have extra points")
        XCTAssertEqual(path.first!, path.last!, "Polygon should be closed.")
    }

    func testFilledPolygon() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1)]
        let polygon = Polygon(points: points, isFilled: true)

        XCTAssertEqual(polygon.paths.count, 1, "Should be one path in polygon")
        let path = polygon.paths.first!

        XCTAssertEqual(points.count + 1, path.count, "Polygon should have extra points")
        XCTAssertEqual(path.first!, path.last!, "Polygon should be closed.")
    }

    func testFilledPolygonAlreadyClosed() {
        let points = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1), Vec2(x: 1, y:2)]
        let polygon = Polygon(points: points)

        XCTAssertEqual(polygon.paths.count, 1, "Should be one path in polygon")
        let path = polygon.paths.first!

        XCTAssertEqual(points, path, "Polygon should not have extra points")
    }

    func testMultiPathPolygon() {
        let closedpoints = [Vec2(x: 10, y: 20), Vec2(x: 20, y: 20), Vec2(x: 10, y: 10), Vec2(x: 10, y:20)]
        let openpoints = [Vec2(x: 1, y: 2), Vec2(x: 2, y: 2), Vec2(x: 1, y: 1)]
        let polygon = Polygon(paths: [closedpoints, openpoints])

        XCTAssertEqual(polygon.paths.count, 2, "Should be one path in polygon")

        XCTAssertEqual(polygon.paths.first!.count, closedpoints.count, "Closed path shouldn't have more points")
        XCTAssertEqual(polygon.paths.last!.count, openpoints.count + 1, "Open path should have an additional point")
    }
}
