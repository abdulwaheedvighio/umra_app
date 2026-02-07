import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/root_screen.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/dashboard_screen/dashboard_screen.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/views/sign_up_screen/sign_up_screen.dart';
import 'package:umra_app/src/views/user_about_screen/user_about_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class GoToDashboardScreen extends StatefulWidget {


  static const routeName = "/GoToDashboardScreen";

  const GoToDashboardScreen({super.key});

  @override
  State<GoToDashboardScreen> createState() => _GoToDashboardScreenState();
}

class _GoToDashboardScreenState extends State<GoToDashboardScreen> {

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
                      text: "You’re All Set!",
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
                    SizedBox(height: screenHeight * 0.030),
                    CustomTextWidget(
                      text: "Welcome aboard! Your personalized health journey begins now.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textLight,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButtonWidget(
              text: "Start Assessment",
              height: screenHeight * 0.065,
              borderRadius: BorderRadius.circular(50),
              onPressed: () {
                Navigator.pushNamed(context, UserAboutScreen.routeName);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()));
                // navigation logic
              },
            ),
            SizedBox(height: 10),
            CustomElevatedButtonWidget(
              text: "Skip",
              height: screenHeight * 0.065,
              textColor: AppColors.textLight,
              backgroundColor: AppColors.shadow.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(50),
              onPressed: () {
                // navigation logic
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RootScreen(initialMemberName: '')));
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
      child: Image.asset("assets/images/icons/icon_vector3.png"),
    );
  }
}
