import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../bloc/main/main_bloc.dart';
import '../widget/card_widget.dart';
import '../widget/main/main_brightness_placeholder_widget.dart';
import '../widget/main/main_brightness_preset_widget.dart';
import '../widget/main/main_brightness_widget.dart';
import '../widget/main/main_ring_vibrate_widget.dart';
import '../widget/main/main_sound_widget.dart';
import 'small_width_screen.dart';
import 'space_interval_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends EinStateBaseBloc<MainScreen, MainBloc>
    with SingleTickerProviderStateMixin {
  @override
  MainBloc provideBloc() => MainBloc();

  @override
  void initState() {
    super.initState();
    bloc.initialize(this);
  }

  @override
  void initStatePostFrameCallback(Duration duration) {
    super.initStatePostFrameCallback(duration);
    bloc.loadRequiredData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control Center'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardWidget(
              icon: Symbols.display_settings_rounded,
              label: 'Display',
              children: [
                MainBrightnessWidget(bloc: bloc),
                const MainBrightnessPlaceholderWidget(),
                const SizedBox(height: 8.0),
                MainBrightnessPresetWidget(bloc: bloc),
              ],
            ),
            CardWidget(
              icon: Symbols.ear_sound_rounded,
              label: 'Sound',
              trailing: MainRingVibrateWidget(bloc: bloc),
              children: [MainSoundWidget(bloc: bloc)],
            ),
            CardWidget(
              onTap: () => context.push(const SmallWidthScreen()),
              icon: Symbols.fit_page_width_rounded,
              label: 'Smallest Width',
              trailing: const Icon(Symbols.chevron_right_rounded),
            ),
            CardWidget(
              onTap: () => context.push(const SpaceIntervalScreen()),
              icon: Symbols.straighten_rounded,
              label: 'Equally Spaced Intervals',
              trailing: const Icon(Symbols.chevron_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
