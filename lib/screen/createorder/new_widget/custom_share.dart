import 'package:flutter/services.dart';

class CustomShare {
  static const MethodChannel _channel = const MethodChannel('custom_share');

  static Future<void> shareUrl(String url) async {
    await _channel.invokeMethod('shareUrl', {'url': url});
  }
}
