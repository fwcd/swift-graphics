import Utils

public struct Polygon<T: IntExpressibleAlgebraicField> {
    public let paths: [[Vec2<T>]]
    public let color: Color
    public let isFilled: Bool

    public init(
        paths: [[Vec2<T>]],
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.color = color
        self.isFilled = isFilled

        self.paths = paths.compactMap {
            if $0.count > 1 && $0.first! != $0.last {
                var closedPaths = $0
                closedPaths.append($0.first!)
                return closedPaths
            } else if $0.count > 1 {
                return $0
            } else {
                return nil
            }
        }
    }

    public init(
        points: [Vec2<T>],
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.init(paths: [points], color: color, isFilled: isFilled)
    }
}
