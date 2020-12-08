// @dart = 2.10
part of dart.ui;

class MockPath implements Path {
  factory MockPath.from() {
    return MockPath();
  }

  MockPath();

  PathFillType get fillType => PathFillType.nonZero;
  set fillType(PathFillType value) {}
  void moveTo(double x, double y) {}
  void relativeMoveTo(double dx, double dy) {}
  void lineTo(double x, double y) {}
  void relativeLineTo(double dx, double dy) {}
  void quadraticBezierTo(double x1, double y1, double x2, double y2) {}
  void relativeQuadraticBezierTo(double x1, double y1, double x2, double y2) {}
  void cubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {}
  void relativeCubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {}
  void conicTo(double x1, double y1, double x2, double y2, double w) {}
  void relativeConicTo(double x1, double y1, double x2, double y2, double w) {}
  void arcTo(
      Rect rect, double startAngle, double sweepAngle, bool forceMoveTo) {}
  void arcToPoint(
    Offset arcEnd, {
    Radius radius = Radius.zero,
    double rotation = 0.0,
    bool largeArc = false,
    bool clockwise = true,
  }) {}
  void relativeArcToPoint(
    Offset arcEndDelta, {
    Radius radius = Radius.zero,
    double rotation = 0.0,
    bool largeArc = false,
    bool clockwise = true,
  }) {}
  void addRect(Rect rect) {}
  void addOval(Rect oval) {}
  void addArc(Rect oval, double startAngle, double sweepAngle) {}
  void addPolygon(List<Offset> points, bool close) {}
  void addRRect(RRect rrect) {}
  void addPath(Path path, Offset offset, {Float64List? matrix4}) {}
  void extendWithPath(Path path, Offset offset, {Float64List? matrix4}) {}
  void close() {}
  void reset() {}
  bool contains(Offset point) {
    return false;
  }

  Path shift(Offset offset) {
    return MockPath();
  }

  Path transform(Float64List matrix4) {
    return MockPath();
  }

  // see https://skia.org/user/api/SkPath_Reference#SkPath_getBounds
  Rect getBounds() {
    return Rect.zero;
  }

  static Path combine(PathOperation operation, Path path1, Path path2) {
    throw UnimplementedError();
  }

  PathMetrics computeMetrics({bool forceClosed = false}) {
    throw UnimplementedError();
  }
}
