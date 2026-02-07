import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  const ImagePreviewScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const CustomTextWidget(
          text: "Report Preview",
          color: AppColors.cardLight,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          /// 🔹 Image Viewer
          Expanded(
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration:
              const BoxDecoration(color: AppColors.backgroundLight),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),

          /// 🔹 Bottom Info Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.018,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Drag Indicator
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                /// Title
                CustomTextWidget(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 6),

                /// Date + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                      text: date,
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomTextWidget(
                        text: status,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Description
                CustomTextWidget(
                  text:
                  "This report includes detailed medical information related to $title.",
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
