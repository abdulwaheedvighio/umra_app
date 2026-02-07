import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/views/dashboard_screen/widget/category_button_widget.dart';
import 'package:umra_app/src/views/dashboard_screen/widget/dashboard_header_widget.dart';
import 'package:umra_app/src/views/record_file_screen/record_file_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/report_card_widget.dart';
import '../../utils/utils.dart' show screenHeight, screenWidth;

class DashboardScreen extends StatefulWidget {
  final String memberName;
  final String? memberImage;

  static const routeName = "/DashboardScreen";

  const DashboardScreen({super.key, required this.memberName, this.memberImage});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    },
    {
      "image": "assets/images/icons/heart_beat_icon.png",
      "title": "Heart Beat",
      "subTitle": "Last Updated: Today",
      "report": "Stable",
      "reportColor": AppColors.error,
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
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Background color of status bar
        statusBarIconBrightness: Brightness.light, // Android icons (battery, time)
        statusBarBrightness: Brightness.light, // iOS icons
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:  SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // header shows under status bar
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            DashboardHeaderWidget(
              memberName: widget.memberName,
              memberImage: widget.memberImage,
            ),

            /// BASIC VITALS (NO Expanded here ❌)
            SizedBox(height: screenHeight * 0.02),

          _buildSectionHeader(
            title: "Basic Vitals",
            action: "See All",
            onTap: () {
              // Navigate to full notifications screen
              //Navigator.pushNamed(context, NotificationScreen.routeName);
            },
          ),


            SizedBox(height: screenHeight * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CategoryButton(
                    image: "assets/images/icons/hand_blood_icon.png",
                    value: "O+",
                    title: "Blood Group",
                  ),
                  CategoryButton(
                    image: "assets/images/icons/heart_beat_icon.png",
                    value: "96",
                    title: "Heart Rate",
                    subTitle: " bpm",
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            _buildSectionHeader(
              title: "Latest Report",
              action: "See All",
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordFileScreen()));
              }
            ),
            /// ✅ ONLY THIS IS EXPANDED & SCROLLABLE
            Expanded(
              child: ListView.builder(
                //physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
                itemCount: _healthReports.length,
                itemBuilder: (context, index) {
                  final report = _healthReports[index];
                  return ReportCard(
                    image: report['image'],
                    title: report['title'],
                    subTitle: report['subTitle'],
                    report: report['report'],
                    reportColor: report['reportColor'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSectionHeader({
    required String title,
    required String action,
    VoidCallback? onTap, // optional onTap for the action
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),

          // 🔹 Action text with onTap
          GestureDetector(
            onTap: onTap,
            child: CustomTextWidget(
              text: action,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

}

