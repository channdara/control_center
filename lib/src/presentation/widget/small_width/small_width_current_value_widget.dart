import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../bloc/small_width/small_width_bloc.dart';
import '../../bloc/small_width/small_width_bloc_state.dart';
import '../card_widget.dart';

class SmallWidthCurrentValueWidget extends StatelessWidget {
  const SmallWidthCurrentValueWidget({super.key, required this.bloc});

  final SmallWidthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: bloc.loadRequiredData,
      margin: const EdgeInsets.only(bottom: 16.0),
      icon: Symbols.fit_page_width_rounded,
      label: 'Current Value',
      trailing: BlocBuilder(
        bloc: bloc,
        buildWhen: (p, c) => c is SmallWidthStateCurrent,
        builder: (context, state) {
          return Text(
            '${state is SmallWidthStateCurrent ? state.width : ''}',
            style: EinTextStyle.s16Bold,
          );
        },
      ),
    );
  }
}
