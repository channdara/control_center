import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../../extension/double_extension.dart';
import '../../bloc/main/main_bloc.dart';
import '../elevated_button_widget.dart';

class MainBrightnessPresetWidget extends StatelessWidget {
  const MainBrightnessPresetWidget({super.key, required this.bloc});

  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [0.3, 0.0, 0.35, 0.0, 0.4, 0.0, 0.45, 0.0, 0.5].map((e) {
        return e == 0.0
            ? const SizedBox(width: 8.0)
            : Expanded(
                child: ElevatedButtonWidget(
                  onPressed: () {
                    bloc.updateBrightness(e);
                    bloc.setBrightness(e);
                  },
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(4.0),
                  child: AutoSizeText(
                    e.sliderValueToPercentage,
                    minFontSize: 2.0,
                    maxFontSize: 14.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
      }).toList(),
    );
  }
}
