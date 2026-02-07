import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/NotificationScreen";

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Example notification data
  final List<Map<String, String>> _notifications = [
    {
      "title": "Missed Bolus",
      "time": "03:50 PM",
      "message": "SafeArea makes sure UI doesn’t overlap with status bar.",
      "icon": "alarm"
    },
    {
      "title": "New Report Uploaded",
      "time": "01:20 PM",
      "message": "Your family member uploaded a new medical report.",
      "icon": "file_text"
    },
    {
      "title": "Health Reminder",
      "time": "09:00 AM",
      "message": "Time to check your daily blood sugar reading.",
      "icon": "heart"
    },
  ];

  // IconData _getIcon(String key) {
  //   switch (key) {
  //     case "alarm":
  //       return Icons.alarm;
  //     case "file_text":
  //       return Icons.insert_drive_file;
  //     case "heart":
  //       return Icons.favorite;
  //     default:
  //       return Icons.notifications;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: CustomTextWidget(
          text: "Notifications",
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Section Title
            const CustomTextWidget(
              text: "New",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            const SizedBox(height: 10),

            // 🔹 Notifications List
            Expanded(
              child: ListView.separated(
                itemCount: _notifications.length,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _notifications[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: AppColors.textLight.withValues(alpha: 0.20)
                      ),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Notification Icon
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.alarm,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 🔹 Notification Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    text: item["title"]!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomTextWidget(
                                    text: item["time"]!,
                                    fontSize: 12,
                                    color: AppColors.textLight,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomTextWidget(
                                text: item["message"]!,
                                fontSize: 12,
                                color: AppColors.textLight.withOpacity(0.7),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
