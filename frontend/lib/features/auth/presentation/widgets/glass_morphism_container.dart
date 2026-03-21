import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class GlassMorphismContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const GlassMorphismContainer({
    super.key,
    required this.child,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.overlay,
              ),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: maxWidth),
                padding: const EdgeInsets.all(32),
                decoration: AppThemes.glassMorphismDecoration,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}