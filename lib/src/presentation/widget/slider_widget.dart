import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../extension/double_extension.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.onChanged,
    required this.onChangeEnd,
    required this.label,
    required this.value,
    this.step = 15,
    this.showPercentage = false,
    this.min = 0.0,
    this.max = 1.0,
  });

  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final String label;
  final double value;
  final int step;
  final bool showPercentage;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label),
            const Spacer(),
            if (showPercentage)
              Text(value.sliderValueToPercentage, style: EinTextStyle.s14Bold),
          ],
        ),
        Slider(
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
          value: value,
          year2023: false,
          divisions: step,
          padding: EdgeInsets.zero,
          min: min,
          max: max,
        ),
      ],
    );
  }
}
