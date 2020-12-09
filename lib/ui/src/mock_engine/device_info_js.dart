import 'dart:html';

class DeviceInfo {
  static double physicalSizeWidth =
      (document.body?.clientWidth.toDouble() ?? 0.0) *
          (document.window as Window).devicePixelRatio.toDouble();
  static double physicalSizeHeight =
      (document.body?.clientHeight.toDouble() ?? 0.0) *
          (document.window as Window).devicePixelRatio.toDouble();
  static double devicePixelRatio =
      (document.window as Window).devicePixelRatio.toDouble();
}
