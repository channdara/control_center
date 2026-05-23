import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.icon,
    required this.label,
    this.children,
    this.trailing,
    this.onTap,
    this.margin,
  });

  final IconData icon;
  final String label;
  final List<Widget>? children;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              leading: Icon(icon),
              title: Text(label, style: EinTextStyle.s16Bold),
              trailing: trailing,
            ),
            if (children != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
