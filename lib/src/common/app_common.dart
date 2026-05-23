import 'package:flutter/services.dart';

class AppCommon {
  AppCommon._();

  static const double minBrightness = 0.2;
  static const double maxBrightness = 0.8;

  static int get divBrightness =>
      (((maxBrightness - minBrightness) / 5) * 100).toInt();

  static Map<int, List<int>> interpolateSequence(
    List<int> anchors,
    int n, {
    bool enforceEven = false,
  }) {
    final Map<int, List<int>> result = {};
    if (anchors.length < 2) return result;
    for (var i = 0; i < anchors.length - 1; i++) {
      final start = anchors[i];
      final end = anchors[i + 1];
      final List<int> steps = [];
      final totalDelta = end - start;
      final divisions = n + 1;
      for (var j = 1; j <= n; j++) {
        if (enforceEven) {
          final exactValue = start + (totalDelta * j) / divisions;
          final evenValue = (exactValue / 2).round() * 2;
          steps.add(evenValue);
        } else {
          final intermediate = start + (totalDelta * j) ~/ divisions;
          steps.add(intermediate);
        }
      }
      result[start] = steps;
    }
    result[anchors.last] = [];
    return result;
  }

  static Map<num, List<num>> interpolateSequenceNum(List<num> anchors, int n) {
    final Map<num, List<num>> result = {};
    if (anchors.length < 2) return result;
    for (var i = 0; i < anchors.length - 1; i++) {
      final start = anchors[i];
      final end = anchors[i + 1];
      final List<num> steps = [];
      final totalDelta = end - start;
      final divisions = n + 1;
      for (var j = 1; j <= n; j++) {
        final intermediate = start + (totalDelta * j) / divisions;
        steps.add(intermediate);
      }
      result[start] = steps;
    }
    result[anchors.last] = [];
    return result;
  }

  static void copyToClipboard(dynamic data) {
    final clipboard = ClipboardData(text: '$data');
    Clipboard.setData(clipboard);
  }
}
