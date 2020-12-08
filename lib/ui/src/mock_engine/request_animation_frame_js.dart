import 'dart:html' as html;

void requestAnimationFrame(Function(num) callback) {
  html.window.requestAnimationFrame(callback);
}
