import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../bloc/main/main_bloc.dart';

class MainRingVibrateWidget extends StatelessWidget {
  const MainRingVibrateWidget({super.key, required this.bloc});

  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 128.0,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TabBar(
        onTap: bloc.setRingMode,
        controller: bloc.ringTabController,
        dividerHeight: 0.0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20.0),
        ),
        splashBorderRadius: BorderRadius.circular(20.0),
        padding: const EdgeInsets.all(4.0),
        tabs: const [
          Tab(icon: Icon(Symbols.notification_sound_rounded)),
          Tab(icon: Icon(Symbols.mobile_vibrate_rounded)),
        ],
      ),
    );
  }
}
