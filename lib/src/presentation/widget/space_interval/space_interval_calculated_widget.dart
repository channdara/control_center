import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../bloc/space_interval/space_interval_bloc.dart';
import '../../bloc/space_interval/space_interval_bloc_state.dart';

class SpaceIntervalCalculatedWidget extends StatelessWidget {
  const SpaceIntervalCalculatedWidget({super.key, required this.bloc});

  final SpaceIntervalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      buildWhen: (p, c) => c is SpaceIntervalStateCalculated,
      builder: (context, state) {
        final items = state is SpaceIntervalStateCalculated
            ? state.items
            : null;
        if (items == null) return const SizedBox();
        final colorScheme = Theme.of(context).colorScheme;
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            16.0,
            0.0,
            16.0,
            EinMediaQuery.paddingBottom(16.0),
          ),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 4.0),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: item.enable
                  ? colorScheme.secondaryContainer
                  : colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(6.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Text(
                      '${item.type?.label ?? index}',
                      style: EinTextStyle.s16.copyWith(
                        color: item.enable ? null : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.value.toString(),
                        textAlign: TextAlign.end,
                        style: EinTextStyle.s16.copyWith(
                          color: item.enable ? null : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
