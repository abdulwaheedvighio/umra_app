import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("About App"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            /// 🔹 App Logo with shadow & gradient circle
            // Container(
            //   height: 120,
            //   width: 120,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     gradient: const LinearGradient(
            //       colors: [AppColors.primary, AppColors.secondary],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.15),
            //         blurRadius: 20,
            //         offset: const Offset(0, 8),
            //       ),
            //     ],
            //   ),
            //   child: Center(
            //     child: Container(
            //       height: 80,
            //       width: 80,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Colors.white,
            //       ),
            //       child: Center(
            //         child: Image.asset(
            //           "assets/images/app_logo.png", // Replace with your app logo
            //           height: 50,
            //           width: 50,
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),

            /// 🔹 App Name
            const CustomTextWidget(
              text: "Family Health App",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 6),

            /// 🔹 Version
            const CustomTextWidget(
              text: "Version 1.0.0",
              fontSize: 14,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),

            /// 🔹 Description in card with shadow
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const CustomTextWidget(
                text:
                "This app helps you manage family health records, upload medical reports, and track health history efficiently.",
                fontSize: 14,
                color: Colors.black87,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            /// 🔹 Developer Info
            Column(
              children: const [
                CustomTextWidget(
                  text: "Developed by: InnovaTech Solutions",
                  fontSize: 14,
                  color: Colors.black87,
                ),
                SizedBox(height: 4),
                CustomTextWidget(
                  text: "Contact: support@innova.com",
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ],
            ),
            const SizedBox(height: 30),

            /// 🔹 Links with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: Open Privacy Policy link
                  },
                  icon: const Icon(Icons.privacy_tip, color: AppColors.primary),
                  label: const CustomTextWidget(
                    text:  "Privacy Policy",
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),

                TextButton.icon(
                  onPressed: () {
                    // TODO: Open Terms of Service link
                  },
                  icon: const Icon(Icons.description, color: AppColors.primary),
                  label: const CustomTextWidget(
                    text:  "Terms of Service",
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// 🔹 Rate the App Button with gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // TODO: Open app store / play store for rating
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        "Rate the App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
