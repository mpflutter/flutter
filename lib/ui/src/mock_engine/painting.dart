// @dart = 2.10
part of dart.ui;

class MockPaint implements Paint {
  BlendMode get blendMode => BlendMode.clear;
  set blendMode(BlendMode value) {}
  PaintingStyle get style => PaintingStyle.fill;
  set style(PaintingStyle value) {}
  double get strokeWidth => 0.0;
  set strokeWidth(double value) {}
  StrokeCap get strokeCap => StrokeCap.butt;
  set strokeCap(StrokeCap value) {}
  StrokeJoin get strokeJoin => StrokeJoin.round;
  set strokeJoin(StrokeJoin value) {}
  bool get isAntiAlias => false;
  set isAntiAlias(bool value) {}

  Color get color => Color(0);
  set color(Color value) {}
  bool get invertColors => false;

  set invertColors(bool value) {}
  Shader? get shader => null;
  set shader(Shader? value) {}
  MaskFilter? get maskFilter => null;
  set maskFilter(MaskFilter? value) {}
  // TODO(ianh): verify that the image drawing methods actually respect this
  FilterQuality get filterQuality => FilterQuality.low;
  set filterQuality(FilterQuality value) {}
  ColorFilter? get colorFilter => null;
  set colorFilter(ColorFilter? value) {}

  double get strokeMiterLimit => 0.0;
  set strokeMiterLimit(double value) {}
  ImageFilter? get imageFilter => null;
  set imageFilter(ImageFilter? value) {}
}

abstract class MockGradient implements Gradient {
  /// Hidden constructor to prevent subclassing.
  MockGradient._();
}

class MockGradientSweep extends MockGradient {
  MockGradientSweep(this.center, this.colors, this.colorStops, this.tileMode,
      this.startAngle, this.endAngle, this.matrix4)
      : assert(_offsetIsValid(center)),
        assert(colors != null), // ignore: unnecessary_null_comparison
        assert(tileMode != null), // ignore: unnecessary_null_comparison
        assert(startAngle != null), // ignore: unnecessary_null_comparison
        assert(endAngle != null), // ignore: unnecessary_null_comparison
        assert(startAngle < endAngle),
        assert(matrix4 == null || _matrix4IsValid(matrix4)),
        super._() {
    _validateColorStops(colors, colorStops);
  }

  final Offset center;
  final List<Color> colors;
  final List<double>? colorStops;
  final TileMode tileMode;
  final double startAngle;
  final double endAngle;
  final Float32List? matrix4;
}

class MockGradientLinear extends MockGradient {
  MockGradientLinear(
    this.from,
    this.to,
    this.colors,
    this.colorStops,
    this.tileMode,
    Float64List? matrix,
  )   : assert(_offsetIsValid(from)),
        assert(_offsetIsValid(to)),
        assert(colors != null), // ignore: unnecessary_null_comparison
        assert(tileMode != null), // ignore: unnecessary_null_comparison
        this.matrix4 = matrix == null ? null : _FastMatrix64(matrix),
        super._() {}

  final Offset from;
  final Offset to;
  final List<Color> colors;
  final List<double>? colorStops;
  final TileMode tileMode;
  final _FastMatrix64? matrix4;
}

// TODO(flutter_web): For transforms and tile modes implement as webgl
// For now only GradientRotation is supported in flutter which is implemented
// for linear gradient.
// See https://github.com/flutter/flutter/issues/32819
class MockGradientRadial extends MockGradient {
  MockGradientRadial(this.center, this.radius, this.colors, this.colorStops,
      this.tileMode, this.matrix4)
      : super._();

  final Offset center;
  final double radius;
  final List<Color> colors;
  final List<double>? colorStops;
  final TileMode tileMode;
  final Float32List? matrix4;
}

class MockGradientConical extends MockGradient {
  MockGradientConical(this.focal, this.focalRadius, this.center, this.radius,
      this.colors, this.colorStops, this.tileMode, this.matrix4)
      : super._();

  final Offset focal;
  final double focalRadius;
  final Offset center;
  final double radius;
  final List<Color> colors;
  final List<double>? colorStops;
  final TileMode tileMode;
  final Float32List? matrix4;
}
