import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umra_app/src/root_screen.dart';
import 'package:umra_app/src/services/user_register_api.dart';
import 'package:umra_app/src/theme/app_theme.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/change_passowrd_screen/change_password_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/notification_screen.dart';
import 'package:umra_app/src/views/upload_medical_record_screen/add_record_screen.dart';
import 'package:umra_app/src/views/dashboard_screen/dashboard_screen.dart';
import 'package:umra_app/src/views/family_member_screen/add_family_medical_report_screen.dart';
import 'package:umra_app/src/views/get_started_screen/get_started_screen.dart';
import 'package:umra_app/src/views/get_started_screen/go_to_dashboard_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/user_edit_profile_screen.dart';
import 'package:umra_app/src/views/onboarding_screen/onboarding_screen.dart';
import 'package:umra_app/src/views/otp_screen/otp_screen.dart';
import 'package:umra_app/src/views/permission_screen/permission_screen.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/views/sign_up_screen/sign_up_screen.dart';
import 'package:umra_app/src/views/splash_screen/splash_screen.dart';
import 'package:umra_app/src/views/upload_medical_record_screen/upload_medical_record.dart';
import 'package:umra_app/src/views/user_about_screen/user_about_screen.dart';
import 'package:umra_app/src/views/user_about_screen/user_health_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserRegisterApi(),
        ),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'UMRA-APP',
        theme: AppTheme.lightTheme,

        home: RootScreen(initialMemberName: ''),
        routes: {
          SplashScreen.routeName : (context) => SplashScreen(),
          GetStartedScreen.routeName : (context) => GetStartedScreen(),
          PermissionScreen.routeName : (context) => PermissionScreen(),
          OnboardingScreen.routeName : (context) => OnboardingScreen(),
          SignUpScreen.routeName : (context) => SignUpScreen(),
          SignInScreen.routeName : (context) => SignInScreen(),
          //RootScreen.routeName : (context) => RootScreen(),
          OtpScreen.routeName : (context) => OtpScreen(),
          UserAboutScreen.routeName : (context) => UserAboutScreen(),
          UserHealthScreen.routeName : (context) => UserHealthScreen(),
          GoToDashboardScreen.routeName : (context) => GoToDashboardScreen(),
          //DashboardScreen.routeName : (context) => DashboardScreen(),
          UserEditProfileScreen.routeName : (context) => UserEditProfileScreen(),
          ChangePasswordScreen.routeName : (context) => ChangePasswordScreen(),
          //AddFamilyMedicalReportScreen.routeName : (context) => AddFamilyMedicalReportScreen(),
          AddRecordScreen.routeName : (context) => AddRecordScreen(),
          NotificationScreen.routeName : (context) => NotificationScreen(),
        },
      ),
    );
  }
}

