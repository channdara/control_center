import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../../common/app_common.dart';
import '../../bloc/small_width/small_width_bloc.dart';
import '../../bloc/small_width/small_width_bloc_state.dart';

class SmallWidthCalculatedWidget extends StatelessWidget {
  const SmallWidthCalculatedWidget({super.key, required this.bloc});

  final SmallWidthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      buildWhen: (p, c) => c is SmallWidthStateCalculated,
      builder: (context, state) {
        final items = state is SmallWidthStateCalculated ? state.items : null;
        if (items == null) return const SizedBox();
        final colorScheme = Theme.of(context).colorScheme;
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(
            16.0,
            0.0,
            16.0,
            EinMediaQuery.paddingBottom(16.0),
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 4.0),
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = item.width == bloc.currentWidth;
            return Card(
              color: item.enable
                  ? selected
                        ? colorScheme.errorContainer
                        : colorScheme.secondaryContainer
                  : colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(6.0),
              ),
              child: InkWell(
                onTap: item.enable
                    ? !selected
                          ? () => AppCommon.copyToClipboard(item.width)
                          : null
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    [item.type?.label, item.width].nonNulls.join(' - '),
                    style: EinTextStyle.s16.copyWith(
                      color: item.enable ? null : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
