import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

import '../../bloc/main/main_bloc.dart';
import '../../bloc/main/main_bloc_state.dart';
import '../slider_widget.dart';

class MainSoundWidget extends StatelessWidget {
  const MainSoundWidget({super.key, required this.bloc});

  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder(
          bloc: bloc,
          buildWhen: (p, c) => c is MainStateVolume || c is MainStateVolumeRing,
          builder: (context, state) {
            return SliderWidget(
              onChanged: (value) => bloc.updateVolume(value, AudioStream.ring),
              onChangeEnd: (value) => bloc.setVolume(value, AudioStream.ring),
              label: 'Phone',
              value: bloc.ringVolume,
            );
          },
        ),
        const SizedBox(height: 16.0),
        BlocBuilder(
          bloc: bloc,
          buildWhen: (p, c) =>
              c is MainStateVolume || c is MainStateVolumeNotification,
          builder: (context, state) {
            return SliderWidget(
              onChanged: (value) =>
                  bloc.updateVolume(value, AudioStream.notification),
              onChangeEnd: (value) =>
                  bloc.setVolume(value, AudioStream.notification),
              label: 'Message & Notification',
              value: bloc.notificationVolume,
            );
          },
        ),
        const SizedBox(height: 16.0),
        BlocBuilder(
          bloc: bloc,
          buildWhen: (p, c) =>
              c is MainStateVolume || c is MainStateVolumeAlarm,
          builder: (context, state) {
            return SliderWidget(
              onChanged: (value) => bloc.updateVolume(value, AudioStream.alarm),
              onChangeEnd: (value) => bloc.setVolume(value, AudioStream.alarm),
              label: 'Alarm',
              value: bloc.alarmVolume,
            );
          },
        ),
      ],
    );
  }
}
