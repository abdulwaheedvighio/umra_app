import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class UserViewProfileScreen extends StatelessWidget {
  static const routeName = "/UserViewProfileScreen";

  final File? profileImage;
  final String fullName;
  final String email;
  final String city;
  final String country;

  const UserViewProfileScreen({
    super.key,
    this.profileImage,
    required this.fullName,
    required this.email,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔹 HEADER with curve
            Container(
              height: screenHeight * 0.22,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomTextWidget(
                    text: "User Profile",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6),
                  CustomTextWidget(
                    text: "View your profile details",
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 PROFILE IMAGE
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    color: Colors.grey.shade200,
                  ),
                  child: ClipOval(
                    child: profileImage != null
                        ? Image.file(
                      profileImage!,
                      fit: BoxFit.cover,
                    )
                        : const Icon(
                      Iconsax.user,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 12, vertical: 4),
                //     decoration: BoxDecoration(
                //       color: AppColors.primary,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: const Text(
                //       "Profile Picture",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🔹 FORM CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _formCard(
                child: Column(
                  children: [
                    _readOnlyField(hintText: "Full Name", value: fullName),
                    _readOnlyField(hintText: "Email Address", value: email),
                    _readOnlyField(hintText: "City", value: city),
                    _readOnlyField(hintText: "Country", value: country),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Read-Only Field
  Widget _readOnlyField({required String hintText, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// 🔹 Form Card Container
  Widget _formCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
