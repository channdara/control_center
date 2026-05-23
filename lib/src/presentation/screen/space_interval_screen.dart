import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../bloc/space_interval/space_interval_bloc.dart';
import '../widget/space_interval/space_interval_calculated_widget.dart';
import '../widget/space_interval/space_interval_form_widget.dart';
import '../widget/space_interval/space_interval_preset_widget.dart';
import '../widget/space_interval/space_interval_type_widget.dart';

class SpaceIntervalScreen extends StatefulWidget {
  const SpaceIntervalScreen({super.key});

  @override
  State<SpaceIntervalScreen> createState() => _SpaceIntervalScreenState();
}

class _SpaceIntervalScreenState
    extends EinStateBaseBloc<SpaceIntervalScreen, SpaceIntervalBloc>
    with SingleTickerProviderStateMixin {
  @override
  SpaceIntervalBloc provideBloc() => SpaceIntervalBloc();

  @override
  void initState() {
    super.initState();
    bloc.initialize(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equally Spaced Intervals')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceIntervalFormWidget(bloc: bloc),
                const SizedBox(height: 8.0),
                SpaceIntervalPresetWidget(bloc: bloc),
                const SizedBox(height: 8.0),
                SpaceIntervalTypeWidget(bloc: bloc),
              ],
            ),
          ),
          Flexible(child: SpaceIntervalCalculatedWidget(bloc: bloc)),
        ],
      ),
    );
  }
}
