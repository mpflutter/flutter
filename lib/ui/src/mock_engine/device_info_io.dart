const bool isTaro = bool.fromEnvironment(
  'mpcore.env.taro',
  defaultValue: false,
);

class DeviceInfo {
  static double physicalSizeWidth = 375.0 * 2.0;
  static double physicalSizeHeight = (isTaro ? 603.0 : 667.0) * 2.0;
  static double devicePixelRatio = 2.0;
  static void listenDeviceSizeChanged(Function callback) {}
}
