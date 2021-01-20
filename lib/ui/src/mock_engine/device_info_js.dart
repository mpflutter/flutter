import 'dart:js' as js;

class DeviceInfo {
  static double physicalSizeWidth = js.context['document']['body']
          ['clientWidth'] /
      js.context['devicePixelRatio'];
  static double physicalSizeHeight = js.context['document']['body']
          ['clientHeight'] /
      js.context['devicePixelRatio'];
  static double devicePixelRatio = js.context['devicePixelRatio'];

  static void listenDeviceSizeChanged(Function callback) {
    js.context.callMethod('addEventListener', [
      'resize',
      (event) {
        physicalSizeWidth = js.context['document']['body']['clientWidth'] /
            js.context['devicePixelRatio'];
        physicalSizeHeight = js.context['document']['body']['clientHeight'] /
            js.context['devicePixelRatio'];
        devicePixelRatio = js.context['devicePixelRatio'];
        callback();
      }
    ]);
  }
}
