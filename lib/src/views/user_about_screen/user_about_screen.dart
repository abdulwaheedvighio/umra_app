import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/user_about_screen/user_health_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_input_field.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class UserAboutScreen extends StatefulWidget {

  static const routeName = "/UserAboutScreen";

  const UserAboutScreen({super.key});

  @override
  State<UserAboutScreen> createState() => _UserAboutScreenState();
}

class _UserAboutScreenState extends State<UserAboutScreen> {

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

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.050,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: "Tell us about ",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    text: "Yourself",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.040,),
              Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
                    child: Column(
                      children: [
                        CustomInputField(
                            hintText: "Name",
                            controller: userNameController
                        ),
                        SizedBox(height: screenHeight * 0.020,),
                        CustomInputField(
                            hintText: "Surname",
                            controller: surnameController
                        ),
                        SizedBox(height: screenHeight * 0.020,),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInputField(
                                fieldType: FieldType.dropdown,
                                dropdownItems: ["Male","Female","Other"],
                                hintText: "Gender",
                                controller: surnameController
                            ),),
                            SizedBox(width: screenWidth * 0.020,),
                            Expanded(child: CustomInputField(
                              hintText: "Select Date",
                              controller: dateOfBirthController,
                              fieldType: FieldType.date,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  initialDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  dateOfBirthController.text =
                                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                }
                              },
                            )
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.020,),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInputField(
                                  fieldType: FieldType.dropdown,
                                  dropdownItems: ["Nawabshah","Hyderabad","Karachi","Other"],
                                  hintText: "City",
                                  controller: surnameController
                              ),),
                            SizedBox(width: screenWidth * 0.020,),
                            Expanded(
                              child: CustomInputField(
                                  fieldType: FieldType.dropdown,
                                  dropdownItems: ["Nawabshah","Hyderabad","Karachi","Other"],
                                  hintText: "Country",
                                  controller: surnameController
                              ),),
                          ],
                        ),


                      ],
                    ),
                  )
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
                child: CustomElevatedButtonWidget(
                    text: "Next",
                    borderRadius: BorderRadius.circular(100),
                    onPressed: (){
                      Navigator.pushNamed(context, UserHealthScreen.routeName);
                    }
                ),
              ),
              Spacer(),
            ],
          )
      ),
    );
  }
}
