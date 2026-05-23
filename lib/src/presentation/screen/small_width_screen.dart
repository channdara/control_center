import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../bloc/small_width/small_width_bloc.dart';
import '../bloc/small_width/small_width_bloc_state.dart';
import '../dialog/confirmation_dialog.dart';
import '../widget/small_width/small_width_actions_widgets.dart';
import '../widget/small_width/small_width_calculated_widget.dart';
import '../widget/small_width/small_width_current_value_widget.dart';
import '../widget/small_width/small_width_force_even_widget.dart';
import '../widget/small_width/small_width_info_widget.dart';
import '../widget/small_width/small_width_step_widget.dart';
import '../widget/small_width/small_width_widget.dart';

class SmallWidthScreen extends StatefulWidget {
  const SmallWidthScreen({super.key});

  @override
  State<SmallWidthScreen> createState() => _SmallWidthScreenState();
}

class _SmallWidthScreenState
    extends EinStateBaseBloc<SmallWidthScreen, SmallWidthBloc>
    with SingleTickerProviderStateMixin {
  @override
  SmallWidthBloc provideBloc() => SmallWidthBloc();

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
  void setupObserver(EinBaseBlocState state) {
    super.setupObserver(state);
    if (state is SmallWidthStateShowOverrideDialog && mounted) {
      ConfirmationDialog.show(
        context,
        '${state.type.name.toUpperCase()} existed',
        'The value of ${state.type.name.toUpperCase()} is existed. Do you want to override it?',
        onPositivePressed: () => bloc.saveSmallWidth(state.type),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smallest Width')),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallWidthCurrentValueWidget(bloc: bloc),
                  const SmallWidthActionsWidgets(),
                  const SizedBox(height: 16.0),
                  const SmallWidthInfoWidget(),
                  const SizedBox(height: 16.0),
                  SmallWidthWidget(bloc: bloc),
                  const SizedBox(height: 8.0),
                  SmallWidthStepWidget(bloc: bloc),
                  const SizedBox(height: 8.0),
                  SmallWidthForceEvenWidget(bloc: bloc),
                ],
              ),
            ),
            SmallWidthCalculatedWidget(bloc: bloc),
          ],
        ),
      ),
    );
  }
}
