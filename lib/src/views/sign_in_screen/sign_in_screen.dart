import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/onboarding_screen/onboarding_screen.dart';
import 'package:umra_app/src/views/otp_screen/otp_screen.dart';
import 'package:umra_app/src/views/permission_screen/permission_screen.dart';
import 'package:umra_app/src/views/sign_up_screen/sign_up_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:ionicons/ionicons.dart';


class SignInScreen extends StatefulWidget {

  static const routeName = "/SignInScreen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.10,),
                Center(
                  child: Column(
                    children: [
                      CustomTextWidget(
                        text: "Login Your Account",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.6,
                      ),
                      SizedBox(height: screenHeight * 0.010,),
                      CustomTextWidget(
                        text: "Welcome back! Sign in using your social account or email to continue us",
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.6,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.040,),
                      Form(
                        child: Column(
                          children: [
        
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Ionicons.mail_outline,color: AppColors.textLight,),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015,),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "password",
                                prefixIcon: Icon(Ionicons.lock_open_outline,color: AppColors.textLight,),
                              ),
                            ),


                            SizedBox(height: screenHeight * 0.10,),
                            CustomElevatedButtonWidget(
                                text: 'Login',
                                fontSize: 15,
                                borderRadius: BorderRadius.circular(50),
                                onPressed: (){
                                  Navigator.pushNamed(context, PermissionScreen.routeName);
                                }
                            ),
                            SizedBox(height: screenHeight * 0.010,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextWidget(
                                  text: "Don't have an Account",
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: screenWidth * 0.012,),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, SignUpScreen.routeName);
                                  },
                                  child: CustomTextWidget(
                                    text: "SignUp",
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.025,),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.shadow,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                CustomTextWidget(text: "OR",color: AppColors.textLight,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.shadow,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.025,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _iconButton(
                                  image: "assets/images/icons/facebook-icon.png"
                                ),
                                _iconButton(
                                  image: "assets/images/icons/google-icon.png"
                                ),
                                _iconButton(
                                  image: "assets/images/icons/apple-black-logo.png"
                                ),
        
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton({required String image}) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.textLight.withValues(alpha: 0.3),
        ),
      ),
        padding: const EdgeInsets.all(10),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

}
