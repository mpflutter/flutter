import 'dart:js' as js;

import 'package:flutter/ui/ui.dart';

class DeviceInfo {
  static double physicalSizeWidth = (() {
    try {
      return js.context['document'].body.clientWidth *
          js.context['devicePixelRatio'];
    } catch (e) {
      try {
        return js.context['document']['body']['clientWidth'] *
            js.context['devicePixelRatio'];
      } catch (e) {
        return 0.0;
      }
    }
  })();

  static double physicalSizeHeight = (() {
    try {
      return js.context['document'].body.clientHeight *
          js.context['devicePixelRatio'];
    } catch (e) {
      try {
        return js.context['document']['body']['clientHeight'] *
            js.context['devicePixelRatio'];
      } catch (e) {
        return 0.0;
      }
    }
  })();

  static double devicePixelRatio = (() {
    try {
      return js.context['devicePixelRatio'];
    } catch (e) {
      return 1.0;
    }
  })();

  static WindowPadding windowPadding = (() {
    try {
      final safeAreaBottomHeight =
          js.context['document']['body']['windowPaddingBottom'];
      if (!(safeAreaBottomHeight is num) || safeAreaBottomHeight.isNaN) {
        return WindowPadding.zero;
      }
      return MockWindowPadding(
        left: 0.0,
        top: 0.0,
        right: 0.0,
        bottom: safeAreaBottomHeight.toDouble(),
      );
    } catch (e) {
      return WindowPadding.zero;
    }
  })();

  static void listenDeviceSizeChanged(Function callback) {
    js.context.callMethod('addEventListener', [
      'resize',
      (event) {
        physicalSizeWidth = (() {
          try {
            return js.context['document'].body.clientWidth *
                js.context['devicePixelRatio'];
          } catch (e) {
            try {
              return js.context['document']['body']['clientWidth'] *
                  js.context['devicePixelRatio'];
            } catch (e) {
              return 0.0;
            }
          }
        })();
        physicalSizeHeight = (() {
          try {
            return js.context['document'].body.clientHeight *
                js.context['devicePixelRatio'];
          } catch (e) {
            try {
              return js.context['document']['body']['clientHeight'] *
                  js.context['devicePixelRatio'];
            } catch (e) {
              return 0.0;
            }
          }
        })();
        devicePixelRatio = js.context['devicePixelRatio'];
        callback();
      }
    ]);
  }
}
