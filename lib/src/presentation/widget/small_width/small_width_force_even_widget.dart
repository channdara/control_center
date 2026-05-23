import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../bloc/small_width/small_width_bloc.dart';
import '../../bloc/small_width/small_width_bloc_state.dart';

class SmallWidthForceEvenWidget extends StatelessWidget {
  const SmallWidthForceEvenWidget({super.key, required this.bloc});

  final SmallWidthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(32.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            const Expanded(
              child: AutoSizeText(
                'Enforce calculate for EVEN numbers',
                minFontSize: 2.0,
                maxFontSize: 14.0,
              ),
            ),
            BlocBuilder(
              bloc: bloc,
              buildWhen: (p, c) => c is SmallWidthStateEnableEven,
              builder: (context, state) {
                return Switch.adaptive(
                  value: bloc.enforceEvenNumbers,
                  onChanged: bloc.onEnforceEvenNumberChanged,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
