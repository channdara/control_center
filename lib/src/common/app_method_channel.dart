import 'dart:io';

import 'package:flutter/services.dart';

class AppMethodChannel {
  AppMethodChannel._();

  static const _platform = MethodChannel('com.mastertipsy.controlcenter');

  static Future<int> getSmallestWidth() async => Platform.isAndroid
      ? (await _platform.invokeMethod<int>('get_smallest_width') ?? 0)
      : 0;
}
