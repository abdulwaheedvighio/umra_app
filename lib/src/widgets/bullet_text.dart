import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 👈 center row
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•",
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          SizedBox(width: 10,),
          SizedBox(
            width: screenWidth * 0.7, // 👈 center block
            child: CustomTextWidget(
              text: text,
              fontSize: 11,
              fontWeight: FontWeight.w300,
              color: AppColors.textLight,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
