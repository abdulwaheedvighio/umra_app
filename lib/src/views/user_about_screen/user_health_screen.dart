import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/dashboard_screen/dashboard_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_input_field.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class UserHealthScreen extends StatefulWidget {

  static const routeName = "/UserHealthScreen";

  const UserHealthScreen({super.key});

  @override
  State<UserHealthScreen> createState() => _UserHealthScreenState();
}

class _UserHealthScreenState extends State<UserHealthScreen> {

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

  final TextEditingController userWeightController = TextEditingController();
  final TextEditingController userAgeController = TextEditingController();
  final TextEditingController userSexController = TextEditingController();
  final TextEditingController userFeverController = TextEditingController();
  final TextEditingController userPulseRateController = TextEditingController();
  final TextEditingController userBloodPressureController = TextEditingController();
  final TextEditingController userDiabetesController = TextEditingController();
  final TextEditingController userBreathingRateController = TextEditingController();
  final TextEditingController userMedicalInfoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.050,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: "Tell us about Your ",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextWidget(
                      text: "Health",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.050,),
                          CustomInputField(
                              hintText: "Weight",
                              controller: userWeightController
                          ),
                          SizedBox(height: screenHeight * 0.020,),
                          Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                    hintText: "Age",
                                    controller: userAgeController
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.020,),
                              Expanded(
                                child: CustomInputField(
                                    fieldType: FieldType.dropdown,
                                    dropdownItems: ["Male","Female","Other"],
                                    hintText: "Sex",
                                    controller: userSexController
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          CustomTextWidget(
                            text: "Basic Vitals",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                    hintText: "Fever",
                                    controller: userFeverController
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.020,),
                              Expanded(
                                child: CustomInputField(
                                    fieldType: FieldType.dropdown,
                                    dropdownItems: ["Male","Female","Other"],
                                    hintText: "Pulse Rate",
                                    controller: userPulseRateController
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.020,),
                          Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                    hintText: "Blood Pressure",
                                    controller: userBloodPressureController
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.020,),
                              Expanded(
                                child: CustomInputField(
                                    fieldType: FieldType.dropdown,
                                    dropdownItems: ["Male","Female","Other"],
                                    hintText: "Diabetes",
                                    controller: userDiabetesController
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.020,),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.45,
                                child: CustomInputField(
                                    hintText: "Breathing Rate",
                                    controller: userBloodPressureController
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.020,),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          CustomTextWidget(
                            text: "Personal Medical info (optional)",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          CustomInputField(
                            maxLines: 3,
                            hintText: "Personal Medical info (optional)",
                            controller: userMedicalInfoController,
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          CustomElevatedButtonWidget(
                              text: "Let's GO",
                              borderRadius: BorderRadius.circular(100),
                              onPressed: (){
                                Navigator.pushNamed(context, DashboardScreen.routeName);
                              }
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
        ),
      ),
    );
  }
}
