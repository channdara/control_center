import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../../common/app_common.dart';
import '../../../extension/double_extension.dart';

class MainBrightnessPlaceholderWidget extends StatelessWidget {
  const MainBrightnessPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppCommon.minBrightness.sliderValueToPercentage,
          style: EinTextStyle.s12,
        ),
        const Text('50%', style: EinTextStyle.s12),
        Text(
          AppCommon.maxBrightness.sliderValueToPercentage,
          style: EinTextStyle.s12,
        ),
      ],
    );
  }
}
