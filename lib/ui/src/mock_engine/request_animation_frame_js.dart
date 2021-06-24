import 'dart:js' as js;

void requestAnimationFrame(Function(num) callback) {
  if (!js.context.hasProperty('requestAnimationFrame')) {
    Future.delayed(Duration(milliseconds: 16)).then((value) {
      callback(DateTime.now().millisecondsSinceEpoch);
    });
  } else {
    js.context.callMethod('requestAnimationFrame', [callback]);
  }
}
