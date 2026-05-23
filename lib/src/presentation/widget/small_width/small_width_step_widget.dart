import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../../bloc/small_width/small_width_bloc.dart';
import '../elevated_button_widget.dart';

class SmallWidthStepWidget extends StatelessWidget {
  const SmallWidthStepWidget({super.key, required this.bloc});

  final SmallWidthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 40.0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TabBar(
              controller: bloc.stepTabController,
              dividerHeight: 0.0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20.0),
              ),
              splashBorderRadius: BorderRadius.circular(20.0),
              padding: const EdgeInsets.all(4.0),
              labelStyle: EinTextStyle.s14Bold,
              tabs: SmallWidthBloc.steps
                  .map((text) => Tab(text: text))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: ElevatedButtonWidget(
            onPressed: bloc.calculateSmallWidth,
            child: const AutoSizeText(
              'Calculate',
              minFontSize: 2.0,
              maxFontSize: 14.0,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
