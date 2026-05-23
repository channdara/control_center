import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../bloc/space_interval/space_interval_bloc.dart';
import '../../bloc/space_interval/space_interval_bloc_state.dart';

class SpaceIntervalTypeWidget extends StatelessWidget {
  const SpaceIntervalTypeWidget({super.key, required this.bloc});

  final SpaceIntervalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(32.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          children: [
            const Expanded(
              child: AutoSizeText(
                'Calculate value in:',
                minFontSize: 2.0,
                maxFontSize: 14.0,
              ),
            ),
            const SizedBox(width: 8.0),
            const AutoSizeText(
              'Decimal',
              minFontSize: 2.0,
              maxFontSize: 14.0,
              style: EinTextStyle.s14Bold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: BlocBuilder(
                bloc: bloc,
                buildWhen: (p, c) => c is SpaceIntervalStateValueType,
                builder: (context, state) {
                  return Switch.adaptive(
                    value: bloc.convertToInteger,
                    onChanged: bloc.onEnforceEvenNumberChanged,
                  );
                },
              ),
            ),
            const AutoSizeText(
              'Integer',
              minFontSize: 2.0,
              maxFontSize: 14.0,
              style: EinTextStyle.s14Bold,
            ),
          ],
        ),
      ),
    );
  }
}
