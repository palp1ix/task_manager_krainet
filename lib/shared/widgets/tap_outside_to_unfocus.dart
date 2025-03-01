import 'package:flutter/material.dart';

// Widget for unfocus input forms

class TapOutsideToUnfocus extends StatelessWidget {
  final Widget child;

  const TapOutsideToUnfocus({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
