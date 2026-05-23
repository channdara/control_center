import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/small_width_type.dart';
import '../../bloc/small_width/small_width_bloc.dart';
import '../elevated_button_widget.dart';

class SmallWidthFormWidget extends StatelessWidget {
  const SmallWidthFormWidget({super.key, required this.bloc});

  final SmallWidthBloc bloc;

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
              child: ElevatedButtonWidget(
                onPressed: () =>
                    bloc.readAndCheckSmallWidth(SmallWidthType.small),
                padding: const EdgeInsets.all(4.0),
                minimumSize: Size.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'Small',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ElevatedButtonWidget(
                onPressed: () =>
                    bloc.readAndCheckSmallWidth(SmallWidthType.medium),
                padding: const EdgeInsets.all(4.0),
                minimumSize: Size.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'Medium',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ElevatedButtonWidget(
                onPressed: () =>
                    bloc.readAndCheckSmallWidth(SmallWidthType.large),
                padding: const EdgeInsets.all(4.0),
                minimumSize: Size.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                ),
                child: const AutoSizeText(
                  'Large',
                  minFontSize: 2.0,
                  maxFontSize: 14.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onTapOutside: (event) => dismissKeyboard(),
                onSubmitted: (text) =>
                    bloc.onFieldSubmitted(text, SmallWidthType.small),
                controller: bloc.smallController,
                focusNode: bloc.smallFocusNode,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _inputDecoration,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                onTapOutside: (event) => dismissKeyboard(),
                onSubmitted: (text) =>
                    bloc.onFieldSubmitted(text, SmallWidthType.medium),
                controller: bloc.mediumController,
                focusNode: bloc.mediumFocusNode,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _inputDecoration,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                onTapOutside: (event) => dismissKeyboard(),
                onSubmitted: (text) {
                  bloc.onFieldSubmitted(text, SmallWidthType.large);
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    bloc.calculateSmallWidth,
                  );
                },
                controller: bloc.largeController,
                focusNode: bloc.largeFocusNode,
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
