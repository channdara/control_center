import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../bloc/space_interval/space_interval_bloc.dart';
import '../../bloc/space_interval/space_interval_bloc_state.dart';

class SpaceIntervalFormWidget extends StatelessWidget {
  const SpaceIntervalFormWidget({super.key, required this.bloc});

  final SpaceIntervalBloc bloc;

  static const _radius = Radius.circular(12.0);
  static const _inputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(8.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: _radius,
        bottomRight: _radius,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'Start',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'End',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'Interval',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
                buildWhen: (p, c) => c is SpaceIntervalStateValueType,
                builder: (context, state) {
                  return TextField(
                    onTapOutside: (event) => dismissKeyboard(),
                    controller: bloc.startController,
                    focusNode: bloc.startFocusNode,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [bloc.inputFormatter],
                    decoration: _inputDecoration,
                  );
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
                buildWhen: (p, c) => c is SpaceIntervalStateValueType,
                builder: (context, state) {
                  return TextField(
                    onTapOutside: (event) => dismissKeyboard(),
                    controller: bloc.endController,
                    focusNode: bloc.endFocusNode,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [bloc.inputFormatter],
                    decoration: _inputDecoration,
                  );
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                onTapOutside: (event) => dismissKeyboard(),
                controller: bloc.intervalController,
                focusNode: bloc.intervalFocusNode,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _inputDecoration,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
