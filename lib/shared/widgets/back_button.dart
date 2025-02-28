import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: 22,
      ),
      onPressed: () {
        context.router.back();
      },
    );
  }
}
