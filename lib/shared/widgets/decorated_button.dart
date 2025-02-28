import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';

class DecoratedButton extends StatelessWidget {
  const DecoratedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.color,
      this.borderRadius});

  final void Function() onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? theme.primaryColor,
          borderRadius: borderRadius ??
              BorderRadius.circular(AppConstants.inputBorderRadius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
