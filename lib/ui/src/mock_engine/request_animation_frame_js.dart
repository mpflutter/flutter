import 'dart:html' as html;

const bool isTaro =
    bool.fromEnvironment('mpcore.env.taro', defaultValue: false);

void requestAnimationFrame(Function(num) callback) {
  if (isTaro) {
    Future.delayed(Duration(milliseconds: 16)).then((value) {
      callback(DateTime.now().millisecondsSinceEpoch);
    });
    return;
  }
  html.window.requestAnimationFrame(callback);
}
