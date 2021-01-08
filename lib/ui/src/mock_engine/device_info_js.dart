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

  static void listenDeviceSizeChanged(Function callback) {
    (document.window as Window).addEventListener('resize', (event) {
      physicalSizeWidth = (document.body?.clientWidth.toDouble() ?? 0.0) *
          (document.window as Window).devicePixelRatio.toDouble();
      physicalSizeHeight = (document.body?.clientHeight.toDouble() ?? 0.0) *
          (document.window as Window).devicePixelRatio.toDouble();
      devicePixelRatio =
          (document.window as Window).devicePixelRatio.toDouble();
      callback();
    });
  }
}
