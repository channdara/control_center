import 'package:app_settings/app_settings.dart';
import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../elevated_button_widget.dart';

class SmallWidthActionsWidgets extends StatelessWidget {
  const SmallWidthActionsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButtonWidget(
            onPressed: () =>
                AppSettings.openAppSettings(type: AppSettingsType.display),
            child: const AutoSizeText(
              'Display Settings',
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
                AppSettings.openAppSettings(type: AppSettingsType.developer),
            child: const AutoSizeText(
              'Developer Options',
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
