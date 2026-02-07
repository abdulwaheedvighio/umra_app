import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/get_started_screen/go_to_dashboard_screen.dart';
import 'package:umra_app/src/views/onboarding_screen/onboarding_screen.dart';
import 'package:umra_app/src/widgets/bullet_text.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class PermissionScreen extends StatefulWidget {

  static const routeName = "/PermissionScreen";

  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 👈 no black strip
        statusBarIconBrightness: Brightness.dark, // Android icons black
        statusBarBrightness: Brightness.light, // iOS icons dark
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // must be white
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextWidget(
                      text: "UMRA",
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    CustomTextWidget(
                      text: "Universal Medical Record App",
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textLight,
                    ),
                    SizedBox(height: screenHeight * 0.10),
                    _containerWidget(),
                    SizedBox(height: screenHeight * 0.035),
                    CustomTextWidget(
                      text: "Your Data Stays Private",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.textLight,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Container(
                      width: screenWidth / 2.8,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.040),
                    Column(
                      children: const [
                        BulletText(
                          text: "Data is encrypted for your security",
                        ),
                        BulletText(
                          text: "Compliant with HIPAA & GDPR",
                        ),
                        BulletText(
                          text: "Never shared without your explicit consent",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButtonWidget(
              text: "Accept & Continue",
              height: screenHeight * 0.065,
              borderRadius: BorderRadius.circular(50),
              onPressed: () {
                Navigator.pushNamed(context, GoToDashboardScreen.routeName);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()));
                // navigation logic
              },
            ),
            SizedBox(height: 10),
            CustomElevatedButtonWidget(
              text: "View Privacy Policy",
              height: screenHeight * 0.065,
              textColor: AppColors.textLight,
              backgroundColor: AppColors.shadow.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(50),
              onPressed: () {
                // navigation logic
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _containerWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/icons/icon_vector1.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 18,
            top: 16,
            child: Image.asset("assets/images/icons/icon_vector2.png"),
          ),
        ],
      ),
    );
  }
}
