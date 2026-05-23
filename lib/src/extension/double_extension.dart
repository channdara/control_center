extension DoubleExtension on double {
  String get sliderValueToPercentage => '${(this * 100).round()}%';
}
