import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final double height;
  final Widget child;
  final EdgeInsetsGeometry? padding; // ✅ correct type
  final BorderRadius? borderRadius;
  final List<Color>? colors;

  const GradientContainer({
    super.key,
    required this.height,
    required this.child,
    this.borderRadius,
    this.colors,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding ?? const EdgeInsets.all(0), // default 0 if null
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: colors ?? [AppColors.primary, AppColors.secondary],
        ),
      ),
      child: child,
    );
  }
}
