import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/utils/responsive.dart';

class CategoryButton extends StatelessWidget {
  final String image;
  final String value;
  final String title;
  final String? subTitle;

  const CategoryButton({
    super.key,
    required this.image,
    required this.value,
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
    final bool isLandscape = Responsive.isLandscape(context);

    // Width, padding, font scaling for landscape
    final double containerWidth = isLandscape
        ? Responsive.wp(context, isTablet ? 30 : 35) // Landscape me thoda compact
        : Responsive.wp(context, isTablet ? 38 : 42);

    final double containerPadding = isLandscape
        ? Responsive.sp(context, 10)
        : Responsive.sp(context, 14);

    final double imageSize = isLandscape
        ? Responsive.sp(context, 25)
        : Responsive.sp(context, 30);

    final double titleFontSize = isLandscape
        ? Responsive.sp(context, 12)
        : Responsive.sp(context, 14);

    final double valueFontSize = isLandscape
        ? Responsive.sp(context, 20)
        : Responsive.sp(context, 24);

    final double subTitleFontSize = isLandscape
        ? Responsive.sp(context, 12)
        : Responsive.sp(context, 14);

    final double spacing1 = isLandscape ? 8.0 : 12.0; // spacing between rows
    final double spacing2 = isLandscape ? 4.0 : 6.0;  // spacing between value and subtitle

    return Container(
      width: containerWidth,
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image, width: imageSize),
              Icon(Icons.more_horiz, size: Responsive.sp(context, 22), color: AppColors.textLight),
            ],
          ),
          SizedBox(height: spacing1),
          CustomTextWidget(
            text: title,
            fontSize: titleFontSize,
            color: AppColors.textLight,
          ),
          SizedBox(height: spacing2),
          Row(
            children: [
              Flexible(
                child: CustomTextWidget(
                  text: value,
                  fontSize: valueFontSize,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CustomTextWidget(
                    text: subTitle!,
                    fontSize: subTitleFontSize,
                    color: AppColors.textLight,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
