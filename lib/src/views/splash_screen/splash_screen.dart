import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/get_started_screen/get_started_screen.dart';
import 'package:umra_app/src/views/permission_screen/permission_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class SplashScreen extends StatefulWidget {

  static const routeName = "/SplashScreen";


  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushNamed(context, GetStartedScreen.routeName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // must be white
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
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
