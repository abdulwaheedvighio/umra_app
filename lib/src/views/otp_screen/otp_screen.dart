import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/user_about_screen/user_about_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/pin_input_widgets.dart';

class OtpScreen extends StatefulWidget {

  static const routeName = "/OtpScreen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

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
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.10,),
                  CustomTextWidget(
                    text: "Enter your OTP Code",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.6,
                  ),
                  SizedBox(height: screenHeight * 0.020,),
                  CustomTextWidget(
                    text: "Get chatting with friends and family today by creating for our chat app!",
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.6,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.10,),
                  OTPInputWidget(
                    onCompleted: (pin) {
                      print("Entered OTP: $pin");
                      // Navigate or verify OTP
                    },
                  ),
                  SizedBox(height: screenHeight * 0.020,),
                  CustomTextWidget(
                    text: "Resend code",
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: screenHeight * 0.10,),
                  CustomElevatedButtonWidget(
                    text: "Verify",
                    fontSize: 15,
                    borderRadius: BorderRadius.circular(50),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // full screen height option
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // BottomSheet header
                                bottomSheet(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }

  Widget bottomSheet(){
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Image.asset("assets/images/icons/vector_icon5.png"),
          ),
          SizedBox(height: 20,),
          CustomTextWidget(
            text: "Verify your account",
            fontSize: 19,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          CustomTextWidget(text: "Your Account has been created!"),
          SizedBox(height: 50,),
          CustomElevatedButtonWidget(
              text: "Continue",
              borderRadius: BorderRadius.circular(50),
              onPressed: (){
                Navigator.pushNamed(context, UserAboutScreen.routeName);
              }
          ),
        ],
      ),
    );
  }
}
