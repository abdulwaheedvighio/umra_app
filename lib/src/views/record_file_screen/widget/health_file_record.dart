import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class HealthFileCard extends StatelessWidget {
  // Removed image, added fileIcon
  final IconData fileIcon;
  final String title;
  final int fileCount;
  final String report;
  final Color reportColor;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onShare;

  const HealthFileCard({
    super.key,
    required this.fileIcon,
    required this.title,
    required this.fileCount,
    required this.report,
    required this.reportColor,
    this.onTap,
    this.onDelete,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.10,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardDark.withOpacity(0.07),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // File type icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.cardLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  fileIcon,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: screenWidth * 0.035),

              // Title & File Count
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(height: 4),
                    CustomTextWidget(
                      text: "$fileCount File${fileCount > 1 ? 's' : ''}",
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ],
                ),
              ),

              // Report Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: reportColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CustomTextWidget(
                  text: report,
                  fontSize: 11,
                  color: AppColors.cardLight,
                ),
              ),

              const SizedBox(width: 6),

              // Options Menu
              FocusScope(
                canRequestFocus: false,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'delete') onDelete?.call();
                    if (value == 'share') onShare?.call();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'share',
                      child: CustomTextWidget(text: 'Share'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: CustomTextWidget(text: 'Delete'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
