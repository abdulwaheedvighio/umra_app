import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/views/change_passowrd_screen/change_password_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/about_app_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/notification_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/user_edit_profile_screen.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/gradient_container_widget.dart';
import 'package:umra_app/src/widgets/logout_confirmation_dialogue.dart';
import 'package:umra_app/src/widgets/profile_option_tile.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // header shows under status bar
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          children: [

            /// 🔷 HEADER

            GradientContainer(
                height: screenHeight * 0.22,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.050,
                  vertical: screenHeight * 0.025,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomTextWidget(
                      text: "Manage Profile",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6),
                    CustomTextWidget(
                      text: "Update your personal information",
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),


            /// 🔷 BODY
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// SECTION: GENERAL
                    const CustomTextWidget(
                      text: "General",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 12),

                    _sectionCard(children: [
                      ProfileOptionTile(
                        icon: Iconsax.user,
                        title: "Edit Profile",
                        onTap: () {
                          Navigator.pushNamed(context, UserEditProfileScreen.routeName);
                        },
                      ),
                      ProfileOptionTile(
                        icon: Iconsax.lock,
                        title: "Change Password",
                        onTap: () {
                          Navigator.pushNamed(context, ChangePasswordScreen.routeName);
                        },
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// SECTION: ACCOUNT
                    const CustomTextWidget(
                      text: "Account",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 12),

                    _sectionCard(children: [
                      ProfileOptionTile(
                        icon: Iconsax.notification,
                        title: "Notifications",
                        onTap: () {
                          Navigator.pushNamed(context, NotificationScreen.routeName);
                        },
                      ),
                      ProfileOptionTile(
                        icon: Iconsax.security,
                        title: "Privacy & Security",
                        onTap: () {},
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// SECTION: OTHER
                    const CustomTextWidget(
                      text: "Others",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 12),

                    _sectionCard(children: [
                      ProfileOptionTile(
                        icon: Iconsax.info_circle,
                        title: "About App",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=> AboutAppScreen(),
                              ),
                          );
                        },
                      ),
                      ProfileOptionTile(
                        icon: Iconsax.logout,
                        title: "Logout",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const LogoutConfirmationDialog(),
                          );
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Section Card
  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
