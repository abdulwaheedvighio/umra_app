import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/model/onboarding_model.dart';
import 'package:umra_app/src/root_screen.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/OnboardingScreen";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

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

  PageController pageController = PageController(); // 👈 add this
  int currentIndex = 0; // track current page

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
        title: "UMRA",
        subtitle: "Universal Medical Record App",
        heading: "You’re All Set!",
        subHeading: "Welcome aboard! Your personalized health journey begins now.",
        image1: "assets/images/icons/icon_vector3.png"
    ),
    OnboardingModel(
        title: "UMRA",
        subtitle: "Universal Medical Record App",
        heading: "Your Personal Health Hub",
        subHeading: "Track Vitals, manage files & stay proactive about your health",
        image1: "assets/images/icons/vector_icon4.png"

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // must be white
      body: PageView.builder(
          //physics: NeverScrollableScrollPhysics(),
          itemCount: onboardingPages.length,
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              currentIndex = index; // update current page
            });
          },
          itemBuilder: (context,index){
            final data = onboardingPages[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextWidget(
                            text: data.title,
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          CustomTextWidget(
                            text: data.subtitle,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          SizedBox(height: screenHeight * 0.10),
                          Container(
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
                                    data.image1,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.035),
                          CustomTextWidget(
                            text: data.heading,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.textLight,
                          ),
                          SizedBox(height: screenHeight * 0.008),
                          Container(
                            width: screenWidth / 2.8,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.040),
                          CustomTextWidget(
                            text: data.subHeading,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: AppColors.textLight,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.040),

                        ],
                      ),
                    ),
                  ),

                  CustomElevatedButtonWidget(
                    text: currentIndex == onboardingPages.length - 1
                        ? "Go Started"
                        : "Next",
                    height: screenHeight * 0.065,
                    borderRadius: BorderRadius.circular(50),
                    onPressed: () {
                      if(currentIndex < onboardingPages.length - 1) {
                        // move to next page
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushNamed(context, RootScreen.routeName);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  index == 0?
                  CustomElevatedButtonWidget(
                    text: "Skip",
                    height: screenHeight * 0.065,
                    textColor: AppColors.textLight,
                    backgroundColor: AppColors.shadow.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(50),
                    onPressed: () {
                      // navigation logic
                    },
                  ) : Container(),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
      ),
    );
  }
}
