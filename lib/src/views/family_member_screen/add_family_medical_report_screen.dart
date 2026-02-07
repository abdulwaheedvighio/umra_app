import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/report_card_widget.dart';

import '../../utils/utils.dart' show screenHeight, screenWidth;

class AddFamilyMedicalReportScreen extends StatefulWidget {

  final String memberName;
  final String memberRelation;

  const AddFamilyMedicalReportScreen({
    super.key, required this.memberName,
    required this.memberRelation
  });

  @override
  State<AddFamilyMedicalReportScreen> createState() => _AddFamilyMedicalReportScreenState();
}

class _AddFamilyMedicalReportScreenState extends State<AddFamilyMedicalReportScreen> {

  final List<Map<String, dynamic>> _healthReports = [
    {
      "image": "assets/images/icons/hand_blood_icon.png",
      "title": "Blood Report",
      "subTitle": "Last Updated: Today",
      "report": "Perception",
      "reportColor": AppColors.primary,
    },
    {
      "image": "assets/images/icons/health_file_icon.png",
      "title": "Perception",
      "subTitle": "Last Updated: Yesterday",
      "report": "Normal",
      "reportColor": AppColors.warning,
    },
    {
      "image": "assets/images/icons/heart_beat_icon.png",
      "title": "Heart Beat",
      "subTitle": "Last Updated: Today",
      "report": "Stable",
      "reportColor": AppColors.error,
    }
  ];

  @override
  void initState() {
    super.initState();
    // Set status bar color & brightness
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // header shows under status bar
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.18,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary, AppColors.secondary],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  CustomTextWidget(
                    text: "${widget.memberName}",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6),
                  CustomTextWidget(
                    text: "${widget.memberRelation}",
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.020,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                itemCount: _healthReports.length,
                itemBuilder: (context, index) {
                  final report = _healthReports[index];
                  return ReportCard(
                    image: report['image']!,
                    title: report['title']!,
                    subTitle: report['subTitle']!,
                    report: report['report']!,
                    fileCount: 2,
                    reportColor: report['reportColor'] as Color,
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
