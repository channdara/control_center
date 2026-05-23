import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.minimumSize,
    this.shape,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final OutlinedBorder? shape;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        padding: padding,
        shape: shape,
        minimumSize: minimumSize,
      ),
      child: child,
    );
  }
}
