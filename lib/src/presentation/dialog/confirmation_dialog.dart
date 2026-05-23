import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

import '../widget/elevated_button_widget.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog._(
    this.title,
    this.description,
    this.positiveButton,
    this.negativeButton,
    this.onPositivePressed,
    this.onNegativePressed,
    this.forceConfirm,
  );

  static Future<void> show(
    BuildContext context,
    String title,
    String description, {
    String? positiveButton,
    String? negativeButton,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
    bool forceConfirm = false,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return ConfirmationDialog._(
          title,
          description,
          positiveButton,
          negativeButton,
          onPositivePressed,
          onNegativePressed,
          forceConfirm,
        );
      },
    );
  }

  final String title;
  final String description;
  final String? positiveButton;
  final String? negativeButton;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final bool forceConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: Text(title, style: EinTextStyle.s16Bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
            child: Text(description, style: EinTextStyle.s14),
          ),
          Row(
            children: [
              Expanded(
                child: forceConfirm
                    ? const SizedBox()
                    : ElevatedButtonWidget(
                        onPressed: () {
                          context.pop();
                          Future.delayed(
                            const Duration(milliseconds: 200),
                            onNegativePressed,
                          );
                        },
                        backgroundColor: Theme.of(context).colorScheme.error,
                        shape: const RoundedRectangleBorder(),
                        child: Text(negativeButton ?? 'No'),
                      ),
              ),
              Expanded(
                child: ElevatedButtonWidget(
                  onPressed: () {
                    context.pop();
                    Future.delayed(
                      const Duration(milliseconds: 200),
                      onPositivePressed,
                    );
                  },
                  shape: const RoundedRectangleBorder(),
                  child: Text(positiveButton ?? 'Yes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
