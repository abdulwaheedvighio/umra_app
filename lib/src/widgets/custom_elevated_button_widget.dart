import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'custom_text_widget.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // Styling
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final Widget? icon;

  const CustomElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w600,
    this.borderRadius,
    this.padding,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : icon != null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 8),
            CustomTextWidget(
              text: text,
              color: textColor ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ],
        )
            : CustomTextWidget(
          text: text,
          color: textColor ?? Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
