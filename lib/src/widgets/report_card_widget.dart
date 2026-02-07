import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import '../utils/utils.dart' show screenHeight, screenWidth;

class ReportCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String report;
  final Color reportColor;
  final int fileCount; // new property

  const ReportCard({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.report,
    required this.reportColor,
    this.fileCount = 0, // default 0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: screenHeight * 0.10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(image, width: 40, height: 40),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: title,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // File count badge

                  ],
                ),
                CustomTextWidget(
                  text: subTitle,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLight,
                ),
                SizedBox(height: screenHeight * 0.008,),
                if (fileCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomTextWidget(
                      text: "$fileCount files",
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: reportColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: CustomTextWidget(
              text: report,
              fontSize: 10,
              color: AppColors.cardLight,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
