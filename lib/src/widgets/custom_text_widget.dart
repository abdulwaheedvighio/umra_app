import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;

  // Text styling
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final String? fontFamily;

  // Layout & behavior
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.fontFamily,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        decoration: decoration ?? TextDecoration.none,
        fontFamily: fontFamily,
      ),
    );
  }
}
