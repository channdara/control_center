import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../../common/app_common.dart';
import '../../bloc/main/main_bloc.dart';
import '../../bloc/main/main_bloc_state.dart';
import '../slider_widget.dart';

class MainBrightnessWidget extends StatelessWidget {
  const MainBrightnessWidget({super.key, required this.bloc});

  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      buildWhen: (p, c) => c is MainStateBrightness,
      builder: (context, state) {
        return SliderWidget(
          onChanged: bloc.updateBrightness,
          onChangeEnd: bloc.setBrightness,
          label: 'Brightness',
          value: bloc.brightness,
          showPercentage: true,
          min: AppCommon.minBrightness,
          max: AppCommon.maxBrightness,
          step: AppCommon.divBrightness,
        );
      },
    );
  }
}
