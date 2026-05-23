import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

class SmallWidthInfoWidget extends StatelessWidget {
  const SmallWidthInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '- The smaller the number, the larger the screen view',
          style: EinTextStyle.s14,
        ),
        Text.rich(
          style: EinTextStyle.s14,
          TextSpan(
            children: [
              TextSpan(text: '- '),
              TextSpan(text: 'Small', style: EinTextStyle.s14Bold),
              TextSpan(text: ', '),
              TextSpan(text: 'Medium', style: EinTextStyle.s14Bold),
              TextSpan(text: ' and '),
              TextSpan(text: 'Large', style: EinTextStyle.s14Bold),
              TextSpan(text: ' refer to the '),
              TextSpan(text: 'Display Size', style: EinTextStyle.s14Bold),
              TextSpan(text: ' config at System Settings'),
            ],
          ),
        ),
        Text.rich(
          style: EinTextStyle.s14,
          TextSpan(
            children: [
              TextSpan(text: '- Number in '),
              TextSpan(text: 'Small', style: EinTextStyle.s14Bold),
              TextSpan(text: ' section will always larger than number in '),
              TextSpan(text: 'Large', style: EinTextStyle.s14Bold),
              TextSpan(text: ' section and the '),
              TextSpan(text: 'Medium', style: EinTextStyle.s14Bold),
              TextSpan(text: ' number will always in between those two'),
            ],
          ),
        ),
      ],
    );
  }
}
