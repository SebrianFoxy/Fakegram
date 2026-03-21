import 'package:flutter/material.dart';

class DarkOverlay extends StatelessWidget {
  final double opacity;

  const DarkOverlay({
    super.key,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ColorFilter.mode(
          Colors.black.withOpacity(opacity),
          BlendMode.darken,
        ),
        child: Container(),
      ),
    );
  }
}