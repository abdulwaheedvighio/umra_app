import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/services/user_register_api.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/utils/utils1.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/widgets/custom_elevated_button_widget.dart';
import 'package:umra_app/src/widgets/custom_input_field.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:ionicons/ionicons.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/SignUpScreen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  bool obscureText = true;
  bool obscureText1 = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    userLastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  void _submitRegistration(UserRegisterApi api) async {
    if (passwordController.text != confirmPasswordController.text) {
      Utils.showSnackBar(context, "Passwords do not match");
      return;
    }

    if (userNameController.text.isEmpty ||
        userLastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      Utils.showSnackBar(context, "Please fill all fields");
      return;
    }

    await api.registerUser(
      email: emailController.text.trim(),
      password: passwordController.text,
      firstName: userNameController.text.trim(),
      lastName: userLastNameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      dateOfBirth: dateOfBirthController.text.trim(), // You can add a DatePicker later
    );

    if (api.isSuccess) {
      Utils.showSnackBar(context, "Registration Successful", color: Colors.green);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    } else if (api.errorMessage != null) {
      Utils.showSnackBar(context, api.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterApi = Provider.of<UserRegisterApi>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.10),
                Center(
                  child: Column(
                    children: [
                      CustomTextWidget(
                        text: "Create an Account",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.6,
                      ),
                      SizedBox(height: screenHeight * 0.010),
                      CustomTextWidget(
                        text: "Get record your medical records today by creating for our UMRA app!",
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.6,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.040),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                prefixIcon: Icon(Ionicons.person_outline, color: AppColors.textLight),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              controller: userLastNameController,
                              decoration: InputDecoration(
                                hintText: "Last Name",
                                prefixIcon: Icon(Ionicons.person_outline, color: AppColors.textLight),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Ionicons.mail_outline, color: AppColors.textLight),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              obscureText: obscureText1,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Ionicons.lock_open_outline, color: AppColors.textLight),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText1 = !obscureText1;
                                    });
                                  },
                                  icon: Icon(
                                    obscureText1 ? Ionicons.eye_off_outline : Ionicons.eye_outline,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextFormField(
                              obscureText: obscureText,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Ionicons.lock_open_outline, color: AppColors.textLight),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    obscureText ? Ionicons.eye_off_outline : Ionicons.eye_outline,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            CustomInputField(
                              hintText: "Select Date",
                              controller: dateOfBirthController,
                              fieldType: FieldType.date,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  // Format as YYYY-MM-DD
                                  final formattedDate =
                                      "${pickedDate.year.toString().padLeft(4, '0')}-"
                                      "${pickedDate.month.toString().padLeft(2, '0')}-"
                                      "${pickedDate.day.toString().padLeft(2, '0')}";

                                  dateOfBirthController.text = formattedDate;
                                }
                              },
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            IntlPhoneField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'PK',
                              onChanged: (phone) {},
                              onCountryChanged: (country) {},
                            ),
                            SizedBox(height: screenHeight * 0.020),
                            userRegisterApi.isLoading
                                ? const CircularProgressIndicator()
                                : CustomElevatedButtonWidget(
                              text: 'Sign Up',
                              fontSize: 15,
                              borderRadius: BorderRadius.circular(50),
                              onPressed: () => _submitRegistration(userRegisterApi),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextWidget(
                                  text: "Existing Account",
                                  fontSize: 13,
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, SignInScreen.routeName);
                                  },
                                  child: CustomTextWidget(
                                    text: "Log in",
                                    fontSize: 13,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
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
}
